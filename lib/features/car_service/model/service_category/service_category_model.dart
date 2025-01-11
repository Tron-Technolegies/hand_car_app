import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_category_model.freezed.dart';
part 'service_category_model.g.dart';

@freezed
class ServiceCategoryModel with _$ServiceCategoryModel{

  const factory ServiceCategoryModel({
    required String id,
    required String name,
  
  }) = _ServiceCategoryModel;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) => _$ServiceCategoryModelFromJson(json);
}