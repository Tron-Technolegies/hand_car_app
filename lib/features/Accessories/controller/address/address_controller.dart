import 'dart:developer';

import 'package:hand_car/features/Accessories/model/address/address_state.dart';
import 'package:hand_car/features/Accessories/services/address_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_controller.g.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  late final AddressApiService _apiService;

  @override
  AddressState build() {
    _apiService = ref.read(addressApiServiceProvider);
    return const AddressState();
  }

    void _updateState(AddressState Function(AddressState state) update) {
    final oldState = state;
    state = update(state);
    log('AddressController: State updated'); // Debug print
    log('Old address count: ${oldState.addresses.length}'); // Debug print
    log('New address count: ${state.addresses.length}'); // Debug print
  }

 // In address_controller.dart

Future<void> addAddress({
  required String street,
  required String city,
  required String state,
  required String zipCode,
  required String country,
  bool isDefault = false,
}) async {
  _updateState((state) => state.copyWith(isLoading: true, error: null));

  try {
    final response = await _apiService.addAddress(
      street: street,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
      isDefault: isDefault,
    );

    if (response.address != null) {
      // Immediately update the state with the new address
      _updateState((state) => state.copyWith(
            isLoading: false,
            addresses: [...state.addresses, response.address!],
      ));
      
      // Then fetch all addresses to ensure consistency
      await fetchAddresses();
    }
  } catch (e) {
    _updateState((state) => state.copyWith(
          isLoading: false,
          error: e.toString(),
    ));
    rethrow;
  }
}

  Future<void> updateAddress({
    required int id,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    _updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      final response = await _apiService.updateAddress(
        id: id,
        street: street,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
        isDefault: isDefault,
      );

      if (response.address != null) {
        _updateState((state) => state.copyWith(
              isLoading: false,
              addresses: state.addresses
                  .map((address) =>
                      address.id == id.toString() ? response.address! : address)
                  .toList(),
            ));
      }
    } catch (e) {
      _updateState((state) => state.copyWith(
            isLoading: false,
            error: e.toString(),
          ));
      rethrow;
    }
  }

  Future<void> deleteAddress(int id) async {
    _updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      await _apiService.deleteAddress(id);

      _updateState((state) => state.copyWith(
            isLoading: false,
            addresses: state.addresses
                .where((address) => address.id != id.toString())
                .toList(),
          ));
    } catch (e) {
      _updateState((state) => state.copyWith(
            isLoading: false,
            error: e.toString(),
          ));
      rethrow;
    }
  }


  Future<void> fetchAddresses() async {
    log('AddressController: fetchAddresses called'); // Debug print
    try {
      _updateState((state) => state.copyWith(isLoading: true, error: null));

      log('AddressController: Calling API service'); // Debug print
      final addresses = await _apiService.getAddresses();
      log('AddressController: Received ${addresses.length} addresses'); // Debug print

      _updateState((state) => state.copyWith(
            isLoading: false,
            addresses: addresses,
          ));
      log('AddressController: State updated with new addresses'); // Debug print
    } catch (e) {
      log('AddressController: Error fetching addresses - $e'); // Debug print
      _updateState((state) => state.copyWith(
            isLoading: false,
            error: e.toString(),
          ));
      rethrow;
    }
  }

  Future<void> setDefaultAddress(int id) async {
    _updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      final defaultAddress = await _apiService.setDefaultAddress(id);

      _updateState((state) => state.copyWith(
            isLoading: false,
            addresses: state.addresses
                .map((address) => address.id == defaultAddress.id
                    ? defaultAddress.copyWith(isDefault: true)
                    : address.copyWith(isDefault: false))
                .toList(),
          ));
    } catch (e) {
      _updateState((state) => state.copyWith(
            isLoading: false,
            error: e.toString(),
          ));
      rethrow;
    }
  }

  Future<void> refresh() async {
    await fetchAddresses();
  }
}

@riverpod
AddressApiService addressApiService(AddressApiServiceRef ref) {
  return AddressApiService();
}
