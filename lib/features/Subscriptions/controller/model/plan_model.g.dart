// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanModelImpl _$$PlanModelImplFromJson(Map<String, dynamic> json) =>
    _$PlanModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      serviceType: json['serviceType'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$PlanModelImplToJson(_$PlanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serviceType': instance.serviceType,
      'duration': instance.duration,
      'price': instance.price,
      'description': instance.description,
    };
