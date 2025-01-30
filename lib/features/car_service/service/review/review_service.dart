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
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();
      
      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Set cookies for authentication
      _dio.options.headers['Cookie'] = _buildCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return await request();
    } on DioException catch (e) {
      log('DioException in _makeAuthenticatedRequest: ${e.message}');
      if (e.response?.statusCode == 401 || 
          e.response?.data?['detail']?.toString().contains('token') == true) {
        if (await _handleTokenExpiration()) {
          // Retry with new token
          return await request();
        }
        throw Exception('Session expired, please login again');
      }
      throw Exception(e.response?.data?['error']?.toString() ?? 'Request failed: ${e.message}');
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  String _buildCookieHeader({
    required String accessToken,
    String? refreshToken,
  }) {
    final cookies = [
      'access_token=$accessToken',
      if (refreshToken != null) 'refresh_token=$refreshToken',
    ];
    log('Setting cookies: ${cookies.join('; ')}');
    return cookies.join('; ');
  }

  Future<bool> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      return false;
    }

    try {
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {
            'Cookie': 'refresh_token=$refreshToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        await _tokenStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );
        
        // Update cookie with new token
        _dio.options.headers['Cookie'] = _buildCookieHeader(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );
        return true;
      }
      
      await _tokenStorage.clearTokens();
      return false;
    } catch (e) {
      log('Token refresh failed: $e');
      await _tokenStorage.clearTokens();
      return false;
    }
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
          validateStatus: (status) => true, // Allow all status codes for proper error handling
        ),
      );
      
      log('Add rating response: ${response.data}');
      
      // Check for authentication errors
      if (response.data?['detail']?.toString().contains('token') == true) {
        return ServiceRatingResponse(
          error: 'Authentication failed. Please login again.'
        );
      }
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }
      
      return ServiceRatingResponse(
        error: response.data['error'] ?? response.data['detail'] ?? 'Failed to add rating'
      );
    });
  }
  Future<ServiceRatingList> getServiceRatings(int serviceId) async {
  
      final response = await _dio.get(
        '/view_service_rating',
        queryParameters: {
          'service_id': serviceId.toString(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('API Response Status Code: ${response.statusCode}');
      log('Raw API Response Data: ${response.data}');

      if (response.statusCode == 404) {
        log('No ratings found');
        return const ServiceRatingList(ratings: []);
      }

      if (response.statusCode == 200) {
        try {
          final ratingsList = ServiceRatingList.fromJson(response.data);
          log('Successfully parsed ratings list');
          log('Number of ratings: ${ratingsList.ratings.length}');
          return ratingsList;
        } catch (e) {
          log('Error parsing ratings list: $e');
          rethrow;
        }
      }

      throw Exception(response.data['error'] ?? 'Failed to fetch ratings');
    
  }


}