
// features/Accessories/controller/review/review_controller.dart
import 'dart:developer';
import 'package:hand_car/features/Accessories/model/review/review_list/review_list_model.dart';
import 'package:hand_car/features/Accessories/model/review/review_response/review_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/services/review_api_services.dart';

part 'review_controller.g.dart';

@Riverpod(keepAlive: false)
class ReviewController extends _$ReviewController {
  late final ReviewApiServices _reviewService;
  int? _currentProductId;

  @override
  FutureOr<ReviewList> build() {
    _reviewService = ReviewApiServices();
    log('ReviewController: Initializing with empty review list');
    return const ReviewList(reviews: []);
  }

  Future<void> refreshReviews() async {
    if (_currentProductId == null) {
      log('ReviewController: Cannot refresh, no product ID available');
      return;
    }
    final productId = _currentProductId!;
    _currentProductId = null;
    await fetchReviews(productId);
  }

  Future<void> fetchReviews(int productId) async {
    if (_currentProductId == productId && !state.isLoading) {
      log('ReviewController: Skipping fetch, already loaded for product ID: $productId');
      return;
    }

    state = const AsyncValue.loading();
    _currentProductId = productId;

    try {
      log('ReviewController: Fetching reviews for product ID: $productId');
      final reviews = await _reviewService.getReviews(productId: productId);
      if (!state.isLoading) {
        log('ReviewController: State no longer loading, aborting update');
        return;
      }
      state = AsyncValue.data(ReviewList(reviews: reviews));
      log('ReviewController: Successfully fetched ${reviews.length} reviews: ${reviews.map((r) => r.toJson()).toList()}');
    } catch (e, stack) {
      log('ReviewController: Error fetching reviews: $e\n$stack');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<ReviewResponse> submitReview({
    required int productId,
    required int rating,
    String? comment,
  }) async {
    if (!TokenStorage().hasValidTokens) {
      return ReviewResponse(error: 'Please login to continue');
    }

    try {
      log('ReviewController: Submitting review for product ID: $productId');
      final response = await _reviewService.addReview(
        productId: productId,
        rating: rating,
        comment: comment?.trim() ?? '',
      );

      if (response.error == null && response.review != null) {
        final currentReviews = state.value?.reviews ?? [];
        state = AsyncValue.data(ReviewList(reviews: [...currentReviews, response.review!]));
        log('ReviewController: Added review, new count: ${currentReviews.length + 1}, review: ${response.review!.toJson()}');
        await refreshReviews();
      }

      return response;
    } catch (e) {
      log('ReviewController: Error submitting review: $e');
      return ReviewResponse(
        error: e.toString().contains('login')
            ? 'Please login to continue'
            : 'Failed to submit review. Please try again.',
      );
    }
  }

  int get totalReviews => state.when(
        data: (reviewList) => reviewList.reviews.length,
        loading: () => 0,
        error: (_, __) => 0,
      );

  double get averageRating => state.when(
        data: (reviewList) {
          if (reviewList.reviews.isEmpty) return 0.0;
          final totalRating = reviewList.reviews.fold<double>(
            0.0,
            (sum, review) => sum + review.rating.toDouble(),
          );
          return (totalRating / reviewList.reviews.length).roundToDouble();
        },
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );

  Map<int, int> get ratingDistribution => state.when(
        data: (reviewList) {
          final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
          for (final review in reviewList.reviews) {
            distribution[review.rating] = (distribution[review.rating] ?? 0) + 1;
          }
          return distribution;
        },
        loading: () => {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
        error: (_, __) => {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
      );
}
