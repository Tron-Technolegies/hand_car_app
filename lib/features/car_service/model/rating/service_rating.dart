

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_rating.freezed.dart';
part 'service_rating.g.dart';

@freezed
class ServiceRating with _$ServiceRating{
  const factory ServiceRating({
   required double rating,
  }) = _ServiceRating;

  factory ServiceRating.fromJson(Map<String, dynamic> json) => _$ServiceRatingFromJson(json);
}
