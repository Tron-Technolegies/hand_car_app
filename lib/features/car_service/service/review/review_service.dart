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

    // Get access token
    final token = tokenStorage.getAccessToken();
    if (token == null) {
      log('No access token found');
      throw Exception('Authentication required. Please log in.');
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
          'Authorization': 'Bearer $token',
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

    if (response.statusCode == 401) {
      await tokenStorage.clearTokens();
      throw Exception('Session expired. Please log in again.');
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
}