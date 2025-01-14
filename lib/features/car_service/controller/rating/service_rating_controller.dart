import 'dart:developer';

import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review/review_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_rating_controller.g.dart';




@riverpod
class ServiceRatingController extends _$ServiceRatingController {
  ReviewService get _reviewService => ref.watch(reviewServiceProvider);

  @override
  FutureOr<ServiceRatingList> build() {
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
    try {
      state = const AsyncLoading();
      final ratings = await _fetchRatings();
      state = AsyncData(ratings);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<ServiceRatingResponse> submitRating({
    required int serviceId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _reviewService.addServiceRating(
        ServiceRatingModel(
          serviceId: serviceId,
          rating: rating,
          comment: comment?.trim(),
        ),
      );

      if (response.error == null) {
        // Only refresh if the submission was successful
        await refreshRatings();
      } else {
        log('Rating submission failed: ${response.error}');
      }

      return response;
    } catch (error) {
      log('Error submitting rating: $error');
      return ServiceRatingResponse(
        error: 'Failed to submit rating: ${error.toString()}'
      );
    }
  }
}