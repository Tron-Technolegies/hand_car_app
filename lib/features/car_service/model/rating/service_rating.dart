

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_rating.freezed.dart';
part 'service_rating.g.dart';

@freezed
class ServiceRatingModel with _$ServiceRatingModel {
  const factory ServiceRatingModel({
    required String serviceId,
    required int rating,
    String? comment,
  }) = _ServiceRatingModel;

  factory ServiceRatingModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingModelFromJson(json);
}
