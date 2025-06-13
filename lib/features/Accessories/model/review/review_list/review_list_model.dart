// features/Accessories/model/review/review_list_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';


part 'review_list_model.freezed.dart';
part 'review_list_model.g.dart';

@freezed
class ReviewList with _$ReviewList {
  const factory ReviewList({
    required List<ReviewModel> reviews,
  }) = _ReviewList;

  factory ReviewList.fromJson(Map<String, dynamic> json) => _$ReviewListFromJson(json);
}