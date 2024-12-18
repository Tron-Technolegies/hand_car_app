import 'package:freezed_annotation/freezed_annotation.dart';

part 'promoted_brands_model.freezed.dart';
part 'promoted_brands_model.g.dart';

@freezed
//PromotodedBrandsModel
class PromotedBrandsModel with _$PromotedBrandsModel {
  const factory PromotedBrandsModel({
    required int id,
    required String name,
  }) = _PromotedBrandsModel;

  factory PromotedBrandsModel.fromJson(Map<String, dynamic> json) =>
      _$PromotedBrandsModelFromJson(json); // Corrected function call
}