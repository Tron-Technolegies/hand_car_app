
// features/Accessories/controller/review/review_controller.dart
import 'dart:developer';
import 'package:hand_car/features/Accessories/model/review/review_list/review_list_model.dart';
import 'package:hand_car/features/Accessories/model/review/review_response/review_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/services/review_api_services.dart';

part 'review_controller.g.dart';

@Riverpod(keepAlive: true) // Changed to true for caching
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
    await fetchReviews(_currentProductId!, forceRefresh: true);
  }

  Future<void> fetchReviews(int productId, {bool forceRefresh = false}) async {
    if (_currentProductId == productId && !forceRefresh && state is AsyncData) {
      log('ReviewController: Using cached reviews for product ID: $productId');
      return;
    }

    if (forceRefresh || _currentProductId != productId) {
      state = const AsyncValue.loading();
      _currentProductId = productId;
    }

    try {
      log('ReviewController: Fetching reviews for product ID: $productId');
      final reviews = await _reviewService.getReviews(productId: productId);
      if (!state.isLoading && !forceRefresh) {
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

      if (response.error == null) {
        log('ReviewController: Review submitted successfully, review: ${response.review?.toJson() ?? 'no review data'}');
        await fetchReviews(productId, forceRefresh: true); // Always refresh
        return response;
      } else {
        log('ReviewController: Review submission failed: ${response.error}');
        return ReviewResponse(error: response.error);
      }
    } catch (e, stack) {
      log('ReviewController: Error submitting review: $e\n$stack');
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
          final validReviews = reviewList.reviews.where((review) => review.rating != null);
          if (validReviews.isEmpty) return 0.0;
          final totalRating = validReviews.fold<double>(
            0.0,
            (sum, review) => sum + (review.rating!.toDouble()),
          );
          return (totalRating / validReviews.length).roundToDouble();
        },
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );

  Map<int, int> get ratingDistribution => state.when(
        data: (reviewList) {
          final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
          for (final review in reviewList.reviews.where((r) => r.rating != null)) {
            distribution[review.rating!] = (distribution[review.rating!] ?? 0) + 1;
          }
          return distribution;
        },
        loading: () => {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
        error: (_, __) => {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
      );
}
