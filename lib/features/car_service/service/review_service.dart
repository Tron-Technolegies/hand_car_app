import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';

// review_service.dart
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

      _dio.options.headers['Cookie'] = _createCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return await request();
    } on DioException catch (e) {
      log('DioException in review service: ${e.message}');
      if (e.response?.statusCode == 401) {
        await _handleTokenExpiration();
        return await request();
      }
      throw Exception(e.response?.data?['error']?.toString() ??
          'Request failed: ${e.message}');
    } catch (e) {
      log('Error in review service: $e');
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

  String _createCookieHeader(
      {required String accessToken, String? refreshToken}) {
    final cookies = [
      'access_token=$accessToken',
      if (refreshToken != null) 'refresh_token=$refreshToken',
    ];
    return cookies.join('; ');
  }

  Future<ServiceRatingResponse> addServiceRating(
      ServiceRatingModel rating) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null) {
        return const ServiceRatingResponse(error: 'Not authenticated');
      }

      log('Adding rating with data: ${{
        'service_id': rating.serviceId,
        'rating': rating.rating,
        if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
      }}');

      final response = await _dio.post(
        '/add_service_rating', // Make sure this matches your backend URL exactly
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Add rating response status: ${response.statusCode}');
      log('Add rating response data: ${response.data}');

      switch (response.statusCode) {
        case 201:
          return const ServiceRatingResponse(
              message: 'Rating added successfully');
        case 400:
          return ServiceRatingResponse(
            error: response.data['error'] ?? 'Invalid request data',
          );
        case 401:
          await _handleTokenExpiration();
          return addServiceRating(rating); // Retry once after token refresh
        case 404:
          return const ServiceRatingResponse(error: 'Service not found');
        case 500:
          return ServiceRatingResponse(
            error: response.data['error'] ?? 'Server error occurred',
          );
        default:
          return ServiceRatingResponse(
            error: response.data['error'] ?? 'Failed to add rating',
          );
      }
    } on DioException catch (e) {
      log('DioException in addServiceRating: ${e.message}');
      log('DioException response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        await _handleTokenExpiration();
        return addServiceRating(rating); // Retry once after token refresh
      }

      return ServiceRatingResponse(
        error: e.response?.data?['error'] ?? 'Network error occurred',
      );
    } catch (e) {
      log('Error in addServiceRating: $e');
      return ServiceRatingResponse(
        error: 'An unexpected error occurred while adding rating',
      );
    }
  }

  Future<ServiceRatingList> getServiceRatings() async {
    log('Fetching service ratings');

    final response = await _dio.get(
      '/view_service_rating',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_tokenStorage.getAccessToken()}'
        },
      ),
    );

    log('Get ratings response: ${response.data}');

    if (response.statusCode == 200) {
      return ServiceRatingList.fromJson(response.data);
    }

    throw Exception(
        response.data['error']?.toString() ?? 'Failed to fetch ratings');
  }
}
