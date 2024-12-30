import 'dart:developer';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/parser.dart' show parse;

part 'plan_model.freezed.dart';


@freezed
class PlanResponse with _$PlanResponse {
  const factory PlanResponse({
    @Default([]) List<PlanModel> plan,
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, dynamic> json) {
    final planData = json['plan'] as List<dynamic>?;
    final plans = planData?.map((e) => 
      PlanModel.fromJson(e as Map<String, dynamic>)
    ).toList() ?? [];
    
    return PlanResponse(plan: plans);
  }
}

@freezed
class PlanModel with _$PlanModel {
  factory PlanModel({
    required int id,
    required String name,
    @JsonKey(name: 'service_type') required String serviceType,
    required String duration,
    required String price,
    String? description,
  }) = _PlanModel;

  static String _cleanDescription(String? text) {
    if (text == null || text.isEmpty) return '';
    
    try {
      final document = parse(text);
      final listItems = document.querySelectorAll('li');

      if (listItems.isNotEmpty) {
        return listItems
            .map((item) => '• ${item.text.trim()}')
            .join('\n');
      }
    } catch (e) {
      log('Error parsing HTML description: $e');
    }
    return text;
  }

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    final rawDescription = json['description'] as String?;
    final cleanDescription = _cleanDescription(rawDescription);

    return PlanModel(
      id: json['id'] as int,
      name: json['name'] as String,
      serviceType: json['service_type'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      description: cleanDescription,
    );
  }
}