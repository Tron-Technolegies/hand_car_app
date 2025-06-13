
// features/Accessories/services/review_api_services.dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';
import 'package:hand_car/features/Accessories/model/review/review_response/review_response.dart';

class ReviewApiServices {
  final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    validateStatus: (status) => status! < 500,
  ));

  final _tokenStorage = TokenStorage();

  Future<T> _makeAuthenticatedRequest<T>(Future<T> Function() request) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      _dio.options.headers['Cookie'] = _createCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      return await request();
    } on DioException catch (e) {
      log('DioException: ${e.message}, Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        await _handleTokenExpiration();
        return await request();
      }
      String errorMessage = e.response?.data['error']?.toString() ?? 'Request failed: ${e.message}';
      throw Exception(errorMessage);
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      throw Exception('Session expired, please login again');
    }

    try {
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        await _tokenStorage.saveTokens(
          accessToken: response.data['access'],
          refreshToken: refreshToken,
        );
      } else {
        await _tokenStorage.clearTokens();
        throw Exception('Session expired, please login again');
      }
    } catch (e) {
      await _tokenStorage.clearTokens();
      throw Exception('Session expired, please login again');
    }
  }

  String _createCookieHeader({required String accessToken, String? refreshToken}) {
    final cookies = [
      'access_token=$accessToken',
      if (refreshToken != null) 'refresh_token=$refreshToken',
    ];
    return cookies.join('; ');
  }

  Future<List<ReviewModel>> getReviews({required int productId}) async {
    return _makeAuthenticatedRequest(() async {
      log('Fetching reviews for product: $productId');
      final response = await _dio.get('/view_review/$productId/');

      log('Get reviews response: status=${response.statusCode}, data=${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> reviewsJson = response.data['reviews'] ?? [];
        return reviewsJson
            .map((json) => ReviewModel.fromJson({
                  'id': json['id'],
                  'rating': json['rating'] is int ? json['rating'] : int.parse(json['rating'].toString()),
                  'comment': json['comment']?.toString(),
                  'user': json['user']?.toString(),
                }))
            .toList();
      }
      throw Exception(response.data['error']?.toString() ?? 'Failed to fetch reviews');
    });
  }

  Future<ReviewResponse> addReview({
    required int productId,
    required int rating,
    required String comment,
  }) async {
    if (!_tokenStorage.hasValidTokens) {
      return ReviewResponse(error: 'Please login to continue');
    }

    return _makeAuthenticatedRequest(() async {
      log('Adding review for product: $productId');
      final response = await _dio.post(
        '/add_review/$productId/',
        data: {
          'rating': rating,
          'comment': comment,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log('Add review response: status=${response.statusCode}, data=${response.data}');
      if (response.statusCode == 201) {
        return ReviewResponse(
          review: ReviewModel.fromJson({
            'id': response.data['review_id'],
            'rating': response.data['rating'],
            'comment': response.data['comment'],
            'user': response.data['user']?.toString() ?? 'Anonymous',
          }),
        );
      }
      return ReviewResponse(error: response.data['error']?.toString() ?? 'Failed to add review');
    });
  }
}
