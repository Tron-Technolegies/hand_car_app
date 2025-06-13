import 'package:hand_car/features/Accessories/services/review_api_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';

part 'review_controller.g.dart';

@riverpod
class ReviewController extends _$ReviewController {
  @override
  AsyncValue<ReviewModel?> build() => const AsyncValue.data(null);

  Future<void> addReview({
    required int productId,
    required int rating,
    required String comment, // Align with addReview's non-nullable comment
  }) async {
    state = const AsyncValue.loading();
    try {
      final review = await ReviewApiServices().addReview(
        productId: productId,
        rating: rating,
        comment: comment,
      );
      state = AsyncValue.data(review);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchReviews({required int productId}) async {
    state = const AsyncValue.loading();
    try {
      final reviews = await ReviewApiServices().getReviews(productId: productId);
      // Optionally store reviews in a separate state or handle in UI
      state = AsyncValue.data(null); // Reset state or update as needed
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}