import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/address/address_model.dart';

part 'address_response.freezed.dart';
part 'address_response.g.dart';

@freezed
class AddressResponse with _$AddressResponse {
  const factory AddressResponse({
    String? message,
    AddressModel? address,
    int? addressId,
    @Default(false) bool isSuccess,
  }) = _AddressResponse;

  // Regular fromJson constructor that will be implemented by freezed
  factory AddressResponse.fromJson(Map<String, dynamic> json) => 
      _$AddressResponseFromJson(_normalizeJson(json));
}

// Helper function to normalize the JSON before parsing
Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
  if (json.containsKey('address_id')) {
    return {
      'message': json['message'],
      'addressId': int.tryParse(json['address_id'].toString()),
      'isSuccess': true,
      'address': null,
    };
  }

  if (json.containsKey('address') && json['address'] is Map<String, dynamic>) {
    return {
      'message': json['message'],
      'address': json['address'],
      'addressId': null,
      'isSuccess': true,
    };
  }

  return {
    ...json,
    'isSuccess': json['isSuccess'] ?? false,
  };
}