import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    @Default([]) List<CartItem> cartItems,
    @Default(0) double totalPrice,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String productName,
    required double productPrice,
    required int quantity,
    required double totalPrice,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}
