// lib/features/car_service/model/service_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

List<String> _parseImages(dynamic images) {
  if (images == null) return [];
  if (images is! List) return [];
  return images.map((e) => e.toString()).where((e) => e.isNotEmpty).toList();
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
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'whatsapp_number') required String whatsappNumber,
    @JsonKey(name: 'service_category', fromJson: _parseCategory) 
    String? serviceCategory,
    @JsonKey(name: 'service_details') required String serviceDetails,
    required String address,
    double? rate,
    @JsonKey(fromJson: _parseImages) @Default([]) List<String> images,
    double? latitude,
    double? longitude,
    double? distance,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}