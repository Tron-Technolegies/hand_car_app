
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

// Utility function to safely parse doubles
double parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is int) return value.toDouble();
  if (value is double) return value;
  if (value is String) {
    return double.tryParse(value) ?? 0.0;
  }
  return 0.0;
}

// Utility function to safely parse integers
int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

@freezed
class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    @Default([]) List<CartItemModel> cartItems,
    CouponModel? appliedCoupon,
    @Default(false) bool isLoading,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  // Computed properties
  double get totalAmount => cartItems.fold(
      0.0, (sum, item) => sum + (item.productPrice * item.quantity));

  double getDiscountAmount() {
    if (appliedCoupon == null) return 0.0;
    final discount = (totalAmount * appliedCoupon!.discountPercentage) / 100;
    return (discount * 100).round() / 100;
  }

  double get discountedTotal {
    final total = totalAmount - getDiscountAmount();
    return (total * 100).round() / 100;
  }

  bool get hasCoupon => appliedCoupon != null;
}

@freezed
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    @JsonKey(name: 'cart_item_id') required int id, // Maps to backend 'cart_item_id'
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_price', fromJson: parseDouble) required double productPrice,
    @JsonKey(fromJson: parseInt) required int quantity,
    @JsonKey(name: 'product_image') String? productImage,
    @JsonKey(name: 'total_price', fromJson: parseDouble) required double totalPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(_transformJson(json));

  static Map<String, dynamic> _transformJson(Map<String, dynamic> json) {
    final id = json['cart_item_id'] ?? json['id']; // Support both for transition
    if (id == null || (id is! int && int.tryParse(id.toString()) == null)) {
      throw FormatException('Missing or invalid cart item ID in JSON: $json');
    }

    final productId = _parseProductId(json);
    if (productId == 0) {
      throw FormatException('Missing or invalid product ID in JSON: $json');
    }

    return {
      'cart_item_id': id is int ? id : parseInt(id.toString()),
      'product_id': productId,
      'product_name': json['product_name'] ?? json['name'] ?? '',
      'product_price': parseDouble(json['product_price'] ?? json['price'] ?? 0.0),
      'quantity': parseInt(json['quantity'] ?? 1),
      'product_image': json['product_image'],
      'total_price': parseDouble(json['total_price'] ?? (parseDouble(json['product_price'] ?? 0.0) * parseInt(json['quantity'] ?? 1))),
    };
  }

  static int _parseProductId(Map<String, dynamic> json) {
    final id = json['product_id'] ?? json['id'];
    if (id == null) return 0;
    if (id is int) return id;
    if (id is String) {
      return parseInt(id) ?? 0;
    }
    return 0;
  }
}
