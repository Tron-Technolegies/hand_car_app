// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanResponseImpl _$$PlanResponseImplFromJson(Map<String, dynamic> json) =>
    _$PlanResponseImpl(
      plan: (json['plan'] as List<dynamic>)
          .map((e) => PlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlanResponseImplToJson(_$PlanResponseImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
    };

_$PlanModelImpl _$$PlanModelImplFromJson(Map<String, dynamic> json) =>
    _$PlanModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      serviceType: json['service_type'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$PlanModelImplToJson(_$PlanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'service_type': instance.serviceType,
      'duration': instance.duration,
      'price': instance.price,
      'description': instance.description,
    };
