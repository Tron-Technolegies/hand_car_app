import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';
part 'cart_model.freezed.dart';


@freezed
class CartModel with _$CartModel {
  const CartModel._(); // Add a private constructor to enable custom getters

  const factory CartModel({
    @Default([]) List<CartItem> cartItems,
    @Default(0.0) double totalAmount,
    CouponModel? appliedCoupon, // Added applied coupon field
  }) = _CartModel;

  /// Custom getter to calculate the discounted total
  double get discountedTotal {
    if (appliedCoupon == null) return totalAmount;
    final discount = totalAmount * (appliedCoupon!.discountPercentage / 100);
    return totalAmount - discount;
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // Handle the specific structure of your API response
    if (json['cart_items'] is List) {
      final items = (json['cart_items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
      return CartModel(
        cartItems: items,
        totalAmount: _calculateTotal(items),
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

/// Helper function to calculate the total amount
double _calculateTotal(List<CartItem> items) {
  return items.fold(0.0, (total, item) {
    return total + (double.tryParse(item.totalPrice) ?? 0.0);
  });
}