// service_rating_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_list_model.freezed.dart';
part 'review_list_model.g.dart';

@freezed
class ServiceRatingList with _$ServiceRatingList {
  const factory ServiceRatingList({
    required List<ServiceRating> ratings,
  }) = _ServiceRatingList;

  factory ServiceRatingList.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingListFromJson(json);
}

@freezed
class ServiceRating with _$ServiceRating {
  const factory ServiceRating({
    required String id,
    required String vendorName,
    required String phoneNumber,
    required double whatsappNumber,  // This is actually the rating value based on your API
    String? serviceCategory,  // This is actually the comment based on your API
  }) = _ServiceRating;

  factory ServiceRating.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingFromJson(json);
}