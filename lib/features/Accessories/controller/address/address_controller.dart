import 'package:hand_car/features/Accessories/model/address/address_state.dart';
import 'package:hand_car/features/Accessories/services/address_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_controller.g.dart';

@Riverpod(keepAlive: true)
class AddressController extends _$AddressController {
  late final AddressService _apiService;

  @override
  AddressState build() {
    _apiService = ref.read(addressApiServiceProvider);
    return const AddressState();
  }

  void updateState(AddressState Function(AddressState state) update) {
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
    updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      final newAddress = await _apiService.addAddress(
        street: street,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
        isDefault: isDefault,
      );

      updateState((state) => state.copyWith(
        isLoading: false,
        addresses: [...state.addresses, newAddress],
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
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
    updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      final updatedAddress = await _apiService.updateAddress(
        id: id,
        street: street,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
        isDefault: isDefault,
      );

      updateState((state) => state.copyWith(
        isLoading: false,
        addresses: state.addresses.map((address) =>
          address.id == id ? updatedAddress : address
        ).toList(),
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> deleteAddress(int id) async {
    updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      await _apiService.deleteAddress(id);

      updateState((state) => state.copyWith(
        isLoading: false,
        addresses: state.addresses.where((address) => address.id != id).toList(),
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> fetchAddresses() async {
    updateState((state) => state.copyWith(isLoading: true, error: null));

    try {
      final addresses = await _apiService.getAddresses();
      updateState((state) => state.copyWith(
        isLoading: false,
        addresses: addresses,
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> refresh() async {
    await fetchAddresses();
  }
}





