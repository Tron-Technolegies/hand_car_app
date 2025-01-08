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

@freezed
class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    @Default([]) List<CartItemModel> cartItems,
    CouponModel? appliedCoupon,
    @Default(false) bool isLoading,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  // Computed properties
  double get totalAmount => cartItems.fold(
        0.0, 
        (sum, item) => sum + (item.productPrice * item.quantity)
      );

  double get discountAmount {
    if (appliedCoupon == null) return 0.0;
    final discount = (totalAmount * appliedCoupon!.discountPercentage) / 100;
    return (discount * 100).round() / 100;
  }

  double get discountedTotal {
    final total = totalAmount - discountAmount;
    return (total * 100).round() / 100;
  }

  bool get hasCoupon => appliedCoupon != null;
}

@freezed
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    @JsonKey(name: 'product_id') 
    int? productId,
    
    @JsonKey(name: 'product_name') 
    required String productName,
    
    @JsonKey(name: 'product_price', fromJson: parseDouble) 
    required double productPrice,
    
    @Default(1) 
    int quantity,
    
    @JsonKey(name: 'product_image')  // Changed from 'product_images' to 'product_image'
    String? productImage,  // Changed variable name to match JSON
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(_transformJson(json));

  static Map<String, dynamic> _transformJson(Map<String, dynamic> json) {
    return {
      'product_id': _parseProductId(json),
      'product_name': json['product_name'] ?? json['name'] ?? '',
      'product_price': parseDouble(json['product_price'] ?? json['price'] ?? 0.0),
      'quantity': json['quantity'] ?? 1,
      'product_image': json['product_image'], // Use the correct field name from API
    };
  }

  // Helper method to parse product ID
  static int? _parseProductId(Map<String, dynamic> json) {
    final id = json['product_id'] ?? json['id'];
    if (id == null) return null;
    
    if (id is int) return id;
    if (id is String) {
      return int.tryParse(id);
    }
    return null;
  }
}