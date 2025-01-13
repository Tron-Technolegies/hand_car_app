import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_response.freezed.dart';
part 'rating_response.g.dart';

@freezed
class ServiceRatingResponse with _$ServiceRatingResponse {
  const factory ServiceRatingResponse({
    String? error,
    String? message,
  }) = _ServiceRatingResponse;

  factory ServiceRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingResponseFromJson(json);
}