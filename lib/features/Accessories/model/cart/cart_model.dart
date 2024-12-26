import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';
part 'cart_model.freezed.dart';


@freezed
@freezed
class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    @Default([]) List<CartItem> cartItems,
    @Default(0.0) double totalAmount,
    CouponModel? appliedCoupon,
    @Default(false) bool isLoading,
  }) = _CartModel;

  double get discountedTotal {
    if (appliedCoupon == null) return totalAmount;
    final discount = totalAmount * (appliedCoupon!.discountPercentage / 100);
    return (totalAmount - discount).roundToDouble();
  }

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  bool get isEmpty => cartItems.isEmpty;
  bool get hasItems => cartItems.isNotEmpty;
  bool get hasCoupon => appliedCoupon != null;
  double get savingsAmount => totalAmount - discountedTotal;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    try {
      final cartItemsList = (json['cart_items'] as List?)?.map((item) {
        if (item is Map<String, dynamic>) {
          return CartItem.fromJson(item);
        }
        return null;
      }).whereType<CartItem>().toList() ?? [];

      final total = double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0;

      CouponModel? coupon;
      if (json['applied_coupon'] != null) {
        try {
          coupon = CouponModel.fromJson(json['applied_coupon']);
        } catch (e) {
          log('Error parsing coupon: $e');
        }
      }

      return CartModel(
        cartItems: cartItemsList,
        totalAmount: total,
        appliedCoupon: coupon,
      );
    } catch (e, stackTrace) {
      log('Error parsing CartModel: $e');
      log('Stack trace: $stackTrace');
      return const CartModel();
    }
  }
}

@freezed
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    @Default(0) int productId,
    @Default('') String productName,
    @Default('0') String productPrice,
    @Default(1) int quantity,
    @Default('0') String totalPrice,
    String? imageUrl,
  }) = _CartItem;

  double get itemTotal => (double.tryParse(productPrice) ?? 0) * quantity;
  bool get isValid => productName.isNotEmpty && double.tryParse(productPrice) != null;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    try {
      return CartItem(
        productId: int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
        productName: json['product_name']?.toString() ?? '',
        productPrice: json['product_price']?.toString() ?? '0',
        quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
        totalPrice: json['total_price']?.toString() ?? '0',
        imageUrl: json['image_url']?.toString(),
      );
    } catch (e) {
      log('Error parsing CartItem: $e');
      return const CartItem();
    }
  }
}