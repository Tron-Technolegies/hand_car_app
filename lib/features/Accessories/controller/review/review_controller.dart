// import 'package:hand_car/features/Accessories/services/review_api_services.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'review_controller.g.dart';

// @riverpod
// class ReviewController extends _$ReviewController {
//   @override
//   AsyncValue<void> build() => const AsyncValue.data(null);

//   Future<void> addReview({
//     required int productId,
//     required int rating,
//     String? comment,
//   }) async {
//     state = const AsyncValue.loading();
    
//    try {
//       final response = await ReviewApiServices().addReview(productId: productId, rating: rating, comment: comment!);
//       state = AsyncValue.data(response);
//     } catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     }
//   }
// }