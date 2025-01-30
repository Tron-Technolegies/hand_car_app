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
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));
  final _tokenStorage = TokenStorage();

  Future<T> _makeAuthenticatedRequest<T>(Future<T> Function() request) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();
      
      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Set both cookie and Authorization header
      _dio.options.headers['Cookie'] = _buildCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      try {
        return await request();
      } on DioException catch (e) {
        if (_isTokenExpiredError(e)) {
          log('Token expired, attempting refresh...');
          if (await _handleTokenExpiration()) {
            // Retry with new token
            return await request();
          }
        }
        rethrow;
      }
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      rethrow;
    }
  }

  bool _isTokenExpiredError(DioException e) {
    return e.response?.statusCode == 401 || 
           e.response?.data?['detail']?.toString().toLowerCase().contains('expired') == true ||
           e.response?.data?['detail']?.toString().contains('Authentication token not found') == true;
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
    try {
      final refreshToken = _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        log('No refresh token available');
        await _tokenStorage.clearTokens();
        return false;
      }

      log('Attempting token refresh');
      final response = await _dio.post(
        '/api/token/refresh',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      log('Refresh token response: ${response.data}');

      if (response.statusCode == 200 && response.data['access'] != null) {
        final newAccessToken = response.data['access'];
        await _tokenStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );
        
        // Update headers
        _dio.options.headers['Cookie'] = _buildCookieHeader(
          accessToken: newAccessToken,
          refreshToken: refreshToken,
        );
        _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
        
        log('Token refreshed successfully');
        return true;
      }
      
      log('Token refresh failed with status: ${response.statusCode}');
      await _tokenStorage.clearTokens();
      return false;
    } catch (e) {
      log('Error during token refresh: $e');
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
      );
      
      log('Add rating response: ${response.data}');
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }
      
      if (_isTokenExpiredError(DioException(
        requestOptions: response.requestOptions,
        response: response,
      ))) {
        return ServiceRatingResponse(
          error: 'Session expired. Please login again.'
        );
      }
      
      return ServiceRatingResponse(
        error: response.data['error'] ?? response.data['detail'] ?? 'Failed to add rating'
      );
    });
  }

  Future<ServiceRatingList> getServiceRatings(int serviceId) async {
    return _makeAuthenticatedRequest(() async {
      log('Fetching ratings for service ID: $serviceId');

      final response = await _dio.get(
        '/view_service_rating',
        queryParameters: {
          'service_id': serviceId.toString(),
        },
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
          log('Successfully parsed ratings list: ${ratingsList.ratings.length} ratings');
          return ratingsList;
        } catch (e) {
          log('Error parsing ratings list: $e');
          throw Exception('Failed to parse ratings data: $e');
        }
      }

      throw Exception(response.data['error'] ?? 'Failed to fetch ratings');
    });
  }
}