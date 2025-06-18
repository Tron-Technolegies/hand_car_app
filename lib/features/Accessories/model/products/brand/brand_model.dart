import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_model.freezed.dart';
part 'brand_model.g.dart';

@freezed
class BrandModel with _$BrandModel {
  const factory BrandModel({
    required String id,
    required String name,
  }) = _BrandModel;

  // Add this simpler factory method
  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'].toString(),
      name: map['name'] as String,
    );
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);
}