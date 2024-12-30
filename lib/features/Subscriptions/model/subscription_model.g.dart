// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionModelImpl _$$SubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionModelImpl(
      plan: json['plan'] as String,
      category: json['category'] as String,
      duration: json['duration'] as String,
      whatsappUrl: json['whatsapp_url'] as String,
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'category': instance.category,
      'duration': instance.duration,
      'whatsapp_url': instance.whatsappUrl,
    };
