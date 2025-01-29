// lib/features/car_service/model/service_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

List<String> _parseImages(dynamic images) {
  if (images == null) return [];
  if (images is! List) return [];
  return images.map((e) => e.toString()).where((e) => e.isNotEmpty).toList();
}

double? _parseRate(dynamic rate) {
  if (rate == null) return null;
  if (rate is num) return rate.toDouble();
  if (rate is String) return double.tryParse(rate);
  return null;
}

String? _parseCategory(dynamic category) {
  if (category == null) return null;
  return category.toString();
}

@freezed
class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
    required int id,
    @JsonKey(name: 'vendor_name') required String vendorName,
    @JsonKey(name: 'phone_number') @Default('') String phoneNumber,
    @JsonKey(name: 'whatsapp_number') @Default('') String whatsappNumber,
    @JsonKey(name: 'service_category', fromJson: _parseCategory)
    String? serviceCategory,
    @JsonKey(name: 'service_details') @Default('') String serviceDetails,
    @Default('') String address,
    @JsonKey(name: 'rate', fromJson: _parseRate) double? rate,
    @JsonKey(fromJson: _parseImages) @Default([]) List<String> images,
    double? latitude,
    double? longitude,
    double? distance,
  }) = _ServiceModel;

  const ServiceModel._();

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}
