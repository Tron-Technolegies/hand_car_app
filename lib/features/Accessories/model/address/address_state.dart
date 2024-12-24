import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/model/address/address_model.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default([]) List<AddressModel> addresses,
    @Default(false) bool isLoading,
    String? error,
  }) = _AddressState;
}
