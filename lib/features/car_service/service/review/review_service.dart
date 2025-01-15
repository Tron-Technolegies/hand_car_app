// review_service.dart
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'dart:developer';

class ReviewService {
   final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    validateStatus: (status) => status! < 500,
  ));
  final _tokenStorage = TokenStorage();
  
  Future<T> _makeAuthenticatedRequest<T>(Future<T> Function() request) async {
    try {
      // Get both tokens
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Set cookies in Dio
      _dio.options.headers['Cookie'] = _createCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return await request();
    } on DioException catch (e) {
      log('DioException in _makeAuthenticatedRequest: ${e.message}');
      if (e.response?.statusCode == 401) {
        // Token expired or invalid
        await _handleTokenExpiration();
        // Retry the request once after handling token expiration
        return await request();
      }
      throw Exception(e.response?.data?['error']?.toString() ?? 'Request failed: ${e.message}');
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      throw Exception('Session expired, please login again');
    }

    try {
      // Call your refresh token endpoint
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        // Save the new tokens
        await _tokenStorage.saveTokens(
          accessToken: response.data['access'],
          refreshToken: refreshToken, // Keep the same refresh token
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

  Future<ServiceRatingResponse> addServiceRating(ServiceRatingModel rating) async {
    return _makeAuthenticatedRequest(() async {
      log('Sending rating data: ${rating.toJson()}');
      
      final response = await _dio.post(
        '/add_service_rating',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      
      log('Add rating response: ${response.data}');
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }
      
      return ServiceRatingResponse(
        error: response.data['error'] ?? 'Failed to add rating'
      );
    });
  }

  Future<ServiceRatingList> getServiceRatings() async {
    return _makeAuthenticatedRequest(() async {
      final response = await _dio.get(
        '/view_service_rating',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      
      log('Get ratings response: ${response.data}');

      if (response.statusCode == 200) {
        return ServiceRatingList.fromJson(response.data);
      }
      
      throw Exception(
        response.data['error'] ?? 'Failed to fetch ratings'
      );
    });
  }
}