
// features/Accessories/model/review/review_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';

part 'review_response.freezed.dart';
part 'review_response.g.dart';

@freezed
class ReviewResponse with _$ReviewResponse {
  const factory ReviewResponse({
    ReviewModel? review,
    String? error,
  }) = _ReviewResponse;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);
}