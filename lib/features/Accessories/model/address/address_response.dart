import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/address/address_model.dart';

part 'address_response.freezed.dart';
part 'address_response.g.dart';

@freezed
class AddressResponse with _$AddressResponse {
  const factory AddressResponse({
    String? message,
    AddressModel? address,
    @Default(false) bool isSuccess,
  }) = _AddressResponse;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);
}