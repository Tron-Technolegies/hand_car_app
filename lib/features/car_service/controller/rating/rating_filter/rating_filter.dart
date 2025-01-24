// lib/features/car_service/controller/rating/rating_filter_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rating_filter.g.dart';

@riverpod
class RatingFilterController extends _$RatingFilterController {
  @override
  double? build() => null;

  void setRatingFilter(double? rating) {
    // Reset to null if selecting already selected rating
    state = state == rating ? null : rating;
  }
}