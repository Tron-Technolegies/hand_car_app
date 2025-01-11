import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
class ServiceModel with _$ServiceModel {
  const factory ServiceModel({
     required int id,
    required String vendorName,
    required String phoneNumber,
    required String whatsappNumber,
    String? serviceCategory,
    required String serviceDetails,
    required String address,
    required double rate,
    required List<String> images,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
}