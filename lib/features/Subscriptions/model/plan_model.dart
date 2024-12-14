import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
/// PlanResponse class to get the data from the API
class PlanResponse with _$PlanResponse {
  const factory PlanResponse({
    required List<PlanModel> plan, // Note: matches the "plan" key from backend
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, dynamic> json) => _$PlanResponseFromJson(json);
}

/// Serializes this PlanModel to a JSON map.
@freezed
class PlanModel with _$PlanModel {
  const factory PlanModel({
    required int id,
    required String name,
    @JsonKey(name: 'service_type') required String serviceType,
    required String duration,
    required String price,
    required String description,
  }) = _PlanModel;

  factory PlanModel.fromJson(Map<String, dynamic> json) => _$PlanModelFromJson(json);
}