

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_rating.freezed.dart';
part 'service_rating.g.dart';


// service_rating.dart


@freezed
class ServiceRatingModel with _$ServiceRatingModel {
  const factory ServiceRatingModel({
    @JsonKey(fromJson: _parseId) required int serviceId,
    required int rating,
    String? comment,
  }) = _ServiceRatingModel;

  factory ServiceRatingModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRatingModelFromJson(json);
}

// Helper function to parse ID from various formats
int _parseId(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.parse(value);
  throw const FormatException('Invalid ID format');
}
