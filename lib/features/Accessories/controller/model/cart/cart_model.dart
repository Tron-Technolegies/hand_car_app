import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';


@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    @Default([]) List<CartItem> cartItems,
    @Default(0.0) double totalAmount,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // Handle the specific structure of your API response
    if (json['cart_items'] is List) {
      return CartModel(
        cartItems: (json['cart_items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList(),
        totalAmount: _calculateTotal((json['cart_items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList()),
      );
    }
    return const CartModel();
  }
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String productName,
    required String productPrice,
    required int quantity,
    required String totalPrice,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productName: json['product_name'] as String,
      productPrice: json['product_price'] as String,
      quantity: json['quantity'] as int,
      totalPrice: json['total_price'] as String,
    );
  }
}

double _calculateTotal(List<CartItem> items) {
  return items.fold(0.0, (total, item) => 
    total + (double.tryParse(item.totalPrice) ?? 0.0));
}
