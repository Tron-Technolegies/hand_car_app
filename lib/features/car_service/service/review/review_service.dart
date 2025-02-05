import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/core/service/base_api_service.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';

class ReviewService extends BaseApiService {
  ReviewService() : super() {
    // Ensure interceptors are properly set up
    setupInterceptors();
  }

  Future<ServiceRatingResponse> addServiceRating(ServiceRatingModel rating) async {
    return withRetry(() async {
      log('Starting add service rating...');
      
      // Get access token and check validity
      final token = tokenStorage.getAccessToken();
      if (token == null) {
        log('No access token found');
        throw Exception('Authentication token not found');
      }

      // Check if token needs refresh before proceeding
      if (tokenStorage.isAccessTokenExpired()) {
        log('Access token expired, attempting refresh...');
        final refreshSuccess = await refreshToken();
        if (!refreshSuccess) {
          throw Exception('Failed to refresh authentication token');
        }
      }

      final response = await dio.post(
        '/add_service_rating',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${tokenStorage.getAccessToken()}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Add rating response status: ${response.statusCode}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        log('Rating added successfully');
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }

      log('Failed to add rating: ${response.data}');
      throw handleApiError(response);
    });
  }

  Future<ServiceRatingList> getServiceRatings(int serviceId) async {
    return withRetry(() async {
      log('Fetching ratings for service ID: $serviceId');

      final response = await dio.get(
        '/view_service_rating',
        queryParameters: {'service_id': serviceId.toString()},
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      log('Get ratings response status: ${response.statusCode}');

      if (response.statusCode == 404) {
        log('No ratings found for service');
        return const ServiceRatingList(ratings: []);
      }

      if (response.statusCode == 200) {
        log('Successfully retrieved ratings');
        return ServiceRatingList.fromJson(response.data);
      }

      log('Failed to get ratings: ${response.data}');
      throw handleApiError(response);
    });
  }

  @override
  void setupInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = tokenStorage.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
              
              // Check if token needs refresh
              if (await shouldRefreshToken()) {
                log('Token needs refresh, attempting refresh...');
                final success = await refreshToken();
                if (success) {
                  final newToken = tokenStorage.getAccessToken();
                  options.headers['Authorization'] = 'Bearer $newToken';
                } else {
                  log('Token refresh failed');
                  await tokenStorage.clearTokens();
                  return handler.reject(
                    DioException(
                      requestOptions: options,
                      error: 'Token refresh failed',
                    ),
                  );
                }
              }
            }
            return handler.next(options);
          } catch (e) {
            log('Request interceptor error: $e');
            return handler.reject(
              DioException(
                requestOptions: options,
                error: e.toString(),
              ),
            );
          }
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            log('Received 401 error, attempting token refresh...');
            try {
              final success = await refreshToken();
              if (success) {
                // Retry the original request with new token
                final newToken = tokenStorage.getAccessToken();
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                final response = await dio.fetch(error.requestOptions);
                return handler.resolve(response);
              }
            } catch (e) {
              log('Error during token refresh: $e');
            }
            await tokenStorage.clearTokens();
          }
          return handler.next(error);
        },
      ),
    );
  }
}