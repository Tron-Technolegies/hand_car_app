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
      duration: (json['duration'] as num).toInt(),
      whatsappUrl: json['whatsapp_url'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'category': instance.category,
      'duration': instance.duration,
      if (instance.whatsappUrl case final value?) 'whatsapp_url': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.price case final value?) 'price': value,
    };
