import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

part 'cart_response.freezed.dart';
part 'cart_response.g.dart';


//Cart Response Model
@freezed
class CartResponse with _$CartResponse {
  const CartResponse._();

  const factory CartResponse({
    String? message,
    int? cartQuantity,
    String? error,
    @Default(false) bool isSuccess,
    CouponModel? appliedCoupon,
  }) = _CartResponse;

  bool get hasError => error != null && error!.isNotEmpty;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  factory CartResponse.error(String errorMessage) => CartResponse(
    error: errorMessage,
    isSuccess: false,
  );

  factory CartResponse.success(String message, {
    int? quantity,
    CouponModel? coupon,
  }) => CartResponse(
    message: message,
    cartQuantity: quantity,
    isSuccess: true,
    appliedCoupon: coupon,
  );
}
