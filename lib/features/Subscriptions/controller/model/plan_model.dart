import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
class PlanModel with _$PlanModel {
  const factory PlanModel({
    required int id,
    required String name,
    required String serviceType,
    required String duration,
    required String price,
    required String description,
  }) = _PlanModel;

  factory PlanModel.fromJson(Map<String, dynamic> json) => _$PlanModelFromJson(json);
}