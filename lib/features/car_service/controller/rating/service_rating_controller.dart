import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review/review_service.dart';

part 'service_rating_controller.g.dart';

@Riverpod(keepAlive: true)
class ServiceRatingController extends _$ServiceRatingController {
  late final ReviewService _reviewService;
  int? _currentServiceId;

  @override
  FutureOr<ServiceRatingList> build() {
    _reviewService = ReviewService();
    return const ServiceRatingList(ratings: []);
  }

  Future<void> refreshRatings() async {
    if (_currentServiceId == null) {
      log('Cannot refresh: no service ID available');
      return;
    }
    
    // Force refresh by temporarily clearing current ID
    final serviceId = _currentServiceId;
    _currentServiceId = null;
    await fetchRatings(serviceId!);
  }

  Future<void> fetchRatings(int serviceId) async {
    if (_currentServiceId == serviceId && !state.isLoading) {
      return;
    }

    state = const AsyncValue.loading();
    _currentServiceId = serviceId;

    try {
      log('Fetching ratings for service ID: $serviceId');
      final ratings = await _reviewService.getServiceRatings(serviceId);
      
      if (!state.isLoading) return;
      
      state = AsyncValue.data(ratings);
      log('Successfully fetched ${ratings.ratings.length} ratings');
    } catch (e, stack) {
      log('Error fetching ratings: $e\n$stack');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<ServiceRatingResponse> submitRating({
    required int serviceId,
    required int rating,
    String? comment,
  }) async {
    if (!TokenStorage().hasTokens) {
      return ServiceRatingResponse(error: 'Please login to continue');
    }

    if (rating < 1 || rating > 5) {
      return ServiceRatingResponse(error: 'Rating must be between 1 and 5');
    }

    final previousState = state;

    try {
      log('Submitting rating for service: $serviceId');

      final response = await _reviewService.addServiceRating(
        ServiceRatingModel(
          serviceId: serviceId,
          rating: rating,
          comment: comment?.trim(),
        ),
      );

      log('Rating submission response: $response');

      if (response.error == null) {
        log('Rating submitted successfully, refreshing list...');
        // Refresh the ratings list after successful submission
        await refreshRatings();
      } else {
        log('Rating submission failed: ${response.error}');
        state = previousState;
      }

      return response;
    } catch (error) {
      log('Error submitting rating: $error');
      state = previousState;
      return ServiceRatingResponse(
        error: 'Failed to submit rating: ${error.toString()}'
      );
    }
  }

  // Getter methods for computed values
  int get totalRatings {
    return state.whenOrNull(
      data: (ratingList) => ratingList.ratings.length,
    ) ?? 0;
  }

  double get averageRating {
    return state.whenOrNull(
      data: (ratingList) {
        if (ratingList.ratings.isEmpty) return 0.0;
        final totalRating = ratingList.ratings.fold<double>(
          0.0,
          (sum, rating) => sum + rating.rating.toDouble(),
        );
        return (totalRating / ratingList.ratings.length).roundToDouble();
      },
    ) ?? 0.0;
  }

  Map<int, int> get ratingDistribution {
    return state.whenOrNull(
      data: (ratingList) {
        final distribution = <int, int>{};
        for (var i = 1; i <= 5; i++) {
          distribution[i] = 0;
        }
        for (final rating in ratingList.ratings) {
          distribution[rating.rating] = (distribution[rating.rating] ?? 0) + 1;
        }
        return distribution;
      },
    ) ?? {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  }
}