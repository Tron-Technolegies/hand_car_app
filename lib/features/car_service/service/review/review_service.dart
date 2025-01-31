import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'dart:developer';

class ReviewService {
  final Dio _dio;
  final TokenStorage _tokenStorage;
  bool _isRefreshing = false;

  ReviewService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          validateStatus: (status) => status! < 500,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )),
        _tokenStorage = TokenStorage() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (await _shouldRefreshToken()) {
            try {
              await _handleTokenExpiration();
            } catch (e) {
              return handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Token refresh failed',
                ),
              );
            }
          }

          final accessToken = _tokenStorage.getAccessToken();
          final refreshToken = _tokenStorage.getRefreshToken();

          if (accessToken != null) {
            options.headers['Cookie'] = _buildCookieHeader(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (_isTokenExpiredError(error) && !_isRefreshing) {
            try {
              if (await _handleTokenExpiration()) {
                final newToken = _tokenStorage.getAccessToken();
                if (newToken != null) {
                  error.requestOptions.headers['Cookie'] = _buildCookieHeader(
                    accessToken: newToken,
                    refreshToken: _tokenStorage.getRefreshToken(),
                  );
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newToken';
                  return handler
                      .resolve(await _dio.fetch(error.requestOptions));
                }
              }
            } catch (e) {
              log('Token refresh error: $e');
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> _shouldRefreshToken() async {
    if (!_tokenStorage.hasValidTokens) return false;

    try {
      final token = _tokenStorage.getAccessToken();
      if (token == null) return true;

      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = _decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

      return DateTime.now()
          .isAfter(expiration.subtract(const Duration(minutes: 5)));
    } catch (e) {
      return true;
    }
  }

  Map<String, dynamic> _decodeJwtPayload(String str) {
    try {
      String normalizedStr = str.replaceAll('-', '+').replaceAll('_', '/');
      switch (normalizedStr.length % 4) {
        case 0:
          break;
        case 2:
          normalizedStr += '==';
          break;
        case 3:
          normalizedStr += '=';
          break;
        default:
          throw FormatException('Invalid base64 string');
      }

      final decoded = utf8.decode(base64Url.decode(normalizedStr));
      return Map<String, dynamic>.from(jsonDecode(decoded));
    } catch (e) {
      throw Exception('Failed to decode JWT payload: $e');
    }
  }

  Future<bool> _handleTokenExpiration() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final refreshToken = _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _dio.post(
        '/refresh_token',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          extra: {'withCredentials': true},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final accessToken = response.data['access'];
        final newRefreshToken = response.data['refresh'] ?? refreshToken;

        if (accessToken != null) {
          await _tokenStorage.saveTokens(
            accessToken: accessToken,
            refreshToken: newRefreshToken,
          );
          return true;
        }
      }
      return false;
    } catch (e) {
      log('Token refresh error: $e');
      await _tokenStorage.clearTokens();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  // Existing methods with updated token handling
  Future<ServiceRatingResponse> addServiceRating(
      ServiceRatingModel rating) async {
    try {
      final response = await _dio.post(
        '/add_service_rating',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
            message: response.data['message'] ?? 'Rating added successfully');
      }

      return ServiceRatingResponse(
          error: response.data['error'] ??
              response.data['detail'] ??
              'Failed to add rating');
    } catch (e) {
      log('Add rating error: $e');
      return ServiceRatingResponse(error: 'Failed to add rating: $e');
    }
  }

  Future<ServiceRatingList> getServiceRatings(int serviceId) async {
    try {
      final response = await _dio.get(
        '/view_service_rating',
        queryParameters: {'service_id': serviceId.toString()},
      );

      if (response.statusCode == 404) {
        return const ServiceRatingList(ratings: []);
      }

      if (response.statusCode == 200) {
        return ServiceRatingList.fromJson(response.data);
      }

      throw Exception(response.data['error'] ?? 'Failed to fetch ratings');
    } catch (e) {
      log('Get ratings error: $e');
      rethrow;
    }
  }

  // Helper methods remain the same
  String _buildCookieHeader(
      {required String accessToken, String? refreshToken}) {
    final cookies = [
      'access_token=$accessToken',
      if (refreshToken != null) 'refresh_token=$refreshToken',
    ];
    return cookies.join('; ');
  }

  bool _isTokenExpiredError(DioException e) {
    return e.response?.statusCode == 401 ||
        e.response?.data?['detail']
                ?.toString()
                .toLowerCase()
                .contains('expired') ==
            true ||
        e.response?.data?['detail']
                ?.toString()
                .contains('Authentication token not found') ==
            true;
  }
}
