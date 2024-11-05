// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      cartItems: (json['cartItems'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'cartItems': instance.cartItems,
      'totalPrice': instance.totalPrice,
    };

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
    };
