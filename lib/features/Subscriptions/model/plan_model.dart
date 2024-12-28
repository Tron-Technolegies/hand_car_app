import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:html/parser.dart' show parse;

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
class PlanResponse with _$PlanResponse {
  const factory PlanResponse({
    required List<PlanModel> plan,
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanResponseFromJson(json);
}

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

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    String cleanDescription = json['description'] as String;
    
    // Parse HTML and extract list items
    final document = parse(cleanDescription);
    final listItems = document.querySelectorAll('li');
    
    if (listItems.isNotEmpty) {
      // Join list items with bullet points
      cleanDescription = listItems
          .map((item) => '• ${item.text.trim()}')
          .join('\n');
    }
    
    return _$PlanModelFromJson({
      ...json,
      'description': cleanDescription,
    });
  }
}