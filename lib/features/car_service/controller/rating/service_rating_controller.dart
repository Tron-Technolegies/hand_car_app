import 'dart:developer';

import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review/review_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_rating_controller.g.dart';






@riverpod
class ServiceRatingController extends _$ServiceRatingController {
  late final ReviewService _reviewService;

  @override
  Future<ServiceRatingList> build() async {
    _reviewService = ReviewService();
    
    if (!TokenStorage().hasTokens) {
      throw Exception('Please login to view ratings');
    }
    
    return _fetchRatings();
  }

  Future<ServiceRatingList> _fetchRatings() async {
    try {
      return await _reviewService.getServiceRatings();
    } catch (e) {
      log('Error fetching ratings: $e');
      rethrow;
    }
  }

  Future<void> refreshRatings() async {
    state = const AsyncValue.loading();
    try {
      if (!TokenStorage().hasTokens) {
        throw Exception('Please login to view ratings');
      }
      
      final ratings = await _fetchRatings();
      state = AsyncValue.data(ratings);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<ServiceRatingResponse> submitRating({
    required int serviceId,
    required int rating,
    String? comment,
  }) async {
    final previousState = state;
    
    try {
      // Check authentication first
      if (!TokenStorage().hasTokens) {
        throw Exception('Please login to continue');
      }

      log('Submitting rating for service: $serviceId');

      // Make API call
      final response = await _reviewService.addServiceRating(
        ServiceRatingModel(
          serviceId: serviceId,
          rating: rating,
          comment: comment?.trim(),
        ),
      );

      log('Rating submission response: $response');

      // Only refresh ratings if submission was successful
      if (response.error == null) {
        await refreshRatings();
      } else {
        log('Rating submission failed: ${response.error}');
        // Restore previous state
        state = previousState;
      }

      return response;
    } catch (error) {
      log('Error submitting rating: $error');
      
      // Restore previous state
      state = previousState;
      
      return ServiceRatingResponse(
        error: 'Failed to submit rating: ${error.toString()}'
      );
    }
  }

  // Computed property for total ratings
  int get totalRatings {
    return state.whenOrNull(
      data: (ratingList) => ratingList.ratings.length,
    ) ?? 0;
  }

  // Computed property for average rating
  double get averageRating {
    return state.whenOrNull(
      data: (ratingList) {
        if (ratingList.ratings.isEmpty) return 0.0;
        final totalRating = ratingList.ratings.fold(0, (sum, rating) => sum + rating.rating);
        return totalRating / ratingList.ratings.length;
      },
    ) ?? 0.0;
  }
}