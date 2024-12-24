

import 'package:hand_car/features/Accessories/model/address/address_model.dart';
import 'package:hand_car/features/Accessories/model/address/address_state.dart';
import 'package:hand_car/features/Accessories/services/address_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_controller.g.dart';

@riverpod
class AddressController extends _$AddressController {
  late final AddressApiService _apiService;

  @override
  AddressState build() {
    _apiService = AddressApiService();
    return const AddressState();
  }

  /// Fetch all addresses
  Future<void> fetchAddresses() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final addressList = await _apiService.getAddresses();

      if (addressList == null) {
        state = state.copyWith(isLoading: false, error: 'No addresses found.');
        return;
      }

      final addresses = addressList
          .map((json) => AddressModel.fromJson(json))
          .toList();

      state = state.copyWith(
        isLoading: false,
        addresses: addresses,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Add a new address
  Future<void> addAddress({
    required String street,
    required String country,
    required String city,
    required String state,
    required String zipCode,
    bool isDefault = false,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _apiService.addAddress(
        street: street,
        country: country,
        city: city,
        state: state,
        zipCode: zipCode,
      );

      final newAddress = AddressModel(
        id: result['id']?.toString(),
        street: street,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
        isDefault: isDefault,
      );

      state = state.copyWith(
        isLoading: false,
        addresses: [...state.addresses, newAddress],
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }
}