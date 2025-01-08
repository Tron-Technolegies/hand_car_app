// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      cartItems: (json['cart_items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      appliedCoupon: json['applied_coupon'] == null
          ? null
          : CouponModel.fromJson(
              json['applied_coupon'] as Map<String, dynamic>),
      isLoading: json['is_loading'] as bool? ?? false,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'cart_items': instance.cartItems.map((e) => e.toJson()).toList(),
      if (instance.appliedCoupon?.toJson() case final value?)
        'applied_coupon': value,
      'is_loading': instance.isLoading,
    };

_$CartItemModelImpl _$$CartItemModelImplFromJson(Map<String, dynamic> json) =>
    _$CartItemModelImpl(
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name'] as String,
      productPrice: parseDouble(json['product_price']),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      productImage: json['product_image'] as String?,
    );

Map<String, dynamic> _$$CartItemModelImplToJson(_$CartItemModelImpl instance) =>
    <String, dynamic>{
      if (instance.productId case final value?) 'product_id': value,
      'product_name': instance.productName,
      'product_price': instance.productPrice,
      'quantity': instance.quantity,
      if (instance.productImage case final value?) 'product_image': value,
    };
