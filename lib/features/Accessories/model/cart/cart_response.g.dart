// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartResponseImpl _$$CartResponseImplFromJson(Map<String, dynamic> json) =>
    _$CartResponseImpl(
      message: json['message'] as String?,
      cartQuantity: (json['cart_quantity'] as num?)?.toInt(),
      error: json['error'] as String?,
      isSuccess: json['is_success'] as bool? ?? false,
      appliedCoupon: json['applied_coupon'] == null
          ? null
          : CouponModel.fromJson(
              json['applied_coupon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartResponseImplToJson(_$CartResponseImpl instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.cartQuantity case final value?) 'cart_quantity': value,
      if (instance.error case final value?) 'error': value,
      'is_success': instance.isSuccess,
      if (instance.appliedCoupon?.toJson() case final value?)
        'applied_coupon': value,
    };
