import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

List<String> _parseImages(dynamic images) {
  if (images == null) return [];
  if (images is! List) return [];
  return images
      .map((e) => e?.toString() ?? '')
      .where((e) => e.isNotEmpty)
      .toList();
}

double? _parseRate(dynamic rate) {
  if (rate == null) return null;
  if (rate is int) return rate.toDouble();
  if (rate is double) return rate;
  if (rate is String) return double.tryParse(rate);
  return null;
}

double? _parseDistance(dynamic distance) {
  if (distance == null) return null;
  if (distance is int) return distance.toDouble();
  if (distance is double) return distance;
  if (distance is String) return double.tryParse(distance);
  return null;
}

@freezed
class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
    required int id,
    @JsonKey(name: 'vendor_name') required String vendorName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'whatsapp_number') required String whatsappNumber,
    @JsonKey(name: 'service_category') String? serviceCategory,
    @JsonKey(name: 'service_details') required String serviceDetails,
    required String address,
    @JsonKey(name: 'rate', fromJson: _parseRate) double? rate,
    @JsonKey(fromJson: _parseImages) @Default([]) List<String> images,
    @JsonKey(fromJson: _parseDistance) double? distance,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}