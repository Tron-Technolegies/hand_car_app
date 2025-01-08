
import 'package:dio/dio.dart';
import 'package:hand_car/core/router/user_validation.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  TokenInterceptor(this._dio, this._tokenStorage);

  @override
  void onError( err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try refreshing it
      try {
        await _refreshToken();

        // Retry the original request with the new token
        final retryRequest = await _retry(err.requestOptions);
        handler.resolve(retryRequest);
        return;
      } catch (e) {
        // Refresh failed, clear tokens and logout user
        await _tokenStorage.clearTokens();
        handler.reject(err); // Forward the original error
        return;
      }
    }
    handler.next(err); // Forward other errors
  }

  Future<void> _refreshToken() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    final response = await _dio.post(
      '/api/token/refresh/',
      data: {'refresh_token': refreshToken},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      final newToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];
      await _tokenStorage.saveTokens(
        accessToken: newToken,
        refreshToken: newRefreshToken,
      );
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final accessToken = _tokenStorage.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $accessToken'},
    );
    return _dio.request(requestOptions.path, options: options, data: requestOptions.data);
  }
}