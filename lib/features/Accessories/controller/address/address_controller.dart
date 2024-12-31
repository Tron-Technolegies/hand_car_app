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
    state = update(state);
  }

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
        _updateState((state) => state.copyWith(
              isLoading: false,
              addresses: [...state.addresses, response.address!],
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
    try {
      _updateState((state) => state.copyWith(isLoading: true, error: null));

      final addresses = await _apiService.getAddresses();

      _updateState((state) => state.copyWith(
            isLoading: false,
            addresses: addresses,
          ));
    } catch (e) {
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
