import 'dart:developer';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review/review_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Future<void> fetchRatings(int serviceId) async {
    // Avoid duplicate fetches for the same service
    if (_currentServiceId == serviceId && !state.isLoading) {
      return;
    }

    state = const AsyncValue.loading();
    _currentServiceId = serviceId;

    try {
      log('Fetching ratings for service ID: $serviceId');
      final ratings = await _reviewService.getServiceRatings(serviceId);
      
      if (!state.isLoading) return; // Check if state is still valid
      
      state = AsyncValue.data(ratings);
      log('Successfully fetched ${ratings.ratings.length} ratings');
    } catch (e, stack) {
      log('Error fetching ratings: $e\n$stack');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refreshRatings([int? serviceId]) async {
    if (serviceId == null && _currentServiceId == null) {
      log('Cannot refresh: no service ID available');
      return;
    }

    await fetchRatings(serviceId ?? _currentServiceId!);
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
        await fetchRatings(serviceId);
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

  // Computed getters
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

  double getRatingPercentage(int stars) {
    if (totalRatings == 0) return 0.0;
    final distribution = ratingDistribution;
    return (distribution[stars] ?? 0) / totalRatings * 100;
  }

  bool get hasRatings => totalRatings > 0;
  
  bool get isLoading => state.isLoading;
  
  String? get error => state.error?.toString();
  
  void clearError() {
    if (state.hasError) {
      state = const AsyncValue.data(ServiceRatingList(ratings: []));
    }
  }
}

// Service-specific provider for individual service ratings
@riverpod
Future<ServiceRatingList> serviceRatings(
   ref,
  int serviceId,
) async {
  final controller = ref.watch(serviceRatingControllerProvider.notifier);
  await controller.fetchRatings(serviceId);
  
  return ref.watch(serviceRatingControllerProvider).valueOrNull ?? 
         const ServiceRatingList(ratings: []);
}

// Provider for filtered ratings by vendor name
@riverpod
List<ServiceRating> vendorRatings(
   ref,
  String vendorName,
) {
  final ratingsState = ref.watch(serviceRatingControllerProvider);
  
  return ratingsState.whenOrNull(
    data: (ratingList) => ratingList.ratings
        .where((rating) => rating.vendorName == vendorName)
        .toList(),
  ) ?? [];
}