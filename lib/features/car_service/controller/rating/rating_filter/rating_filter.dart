import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rating_filter.g.dart';
@riverpod
class RatingFilterController extends _$RatingFilterController {
  @override
  double? build() => null; // null means no filter

  void setRatingFilter(double? rating) {
    state = rating;
  }

  void clearFilter() {
    state = null;
  }
}