// service_rating_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_list_model.freezed.dart';
part 'review_list_model.g.dart';



@freezed
class ServiceRatingList with _$ServiceRatingList {
  const factory ServiceRatingList({
    @JsonKey(name: 'Ratings') required List<ServiceRating> ratings,
  }) = _ServiceRatingList;

  factory ServiceRatingList.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingListFromJson(json);
}

@freezed
class ServiceRating with _$ServiceRating {
  const factory ServiceRating({
    required int id,
    @JsonKey(name: 'vendor_name') required String vendorName,
    required String username,
    required int rating,
    String? comment,
  }) = _ServiceRating;

  factory ServiceRating.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingFromJson(json);
}