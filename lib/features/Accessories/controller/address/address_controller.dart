import 'package:hand_car/features/Accessories/model/address/address_model.dart';
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

  void updateState(AddressState Function(AddressState state) update) {
    state = update(state);
  }

  Future<void> fetchAddresses() async {
    try {
      updateState((state) => state.copyWith(isLoading: true, error: null));

      // Fetch addresses from API
      final addressList = await _apiService.getAddresses();
      final addresses = addressList.map((json) => AddressModel.fromJson(json)).toList();

      updateState((state) => state.copyWith(
        addresses: addresses,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> addAddress({
    required String street,
    required String country,
    required String city,
    required String state,
    required String zipCode,
    bool isDefault = false,
  }) async {
    try {
      updateState((state) => state.copyWith(isLoading: true, error: null));

      // Add address using the API
      final result = await _apiService.addAddress(
        street: street,
        country: country,
        city: city,
        state: state,
        zipCode: zipCode,
        isDefault: isDefault,
      );

      // Create the new address model
      final newAddress = AddressModel(
        id: result['id']?.toString(),
        street: street,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
        isDefault: isDefault,
      );

      updateState((state) => state.copyWith(
        addresses: [...state.addresses, newAddress],
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      updateState((state) => state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void clearError() {
    updateState((state) => state.copyWith(error: null));
  }
}

// Provider for AddressApiService
@riverpod
AddressApiService addressApiService(AddressApiServiceRef ref) {
  return AddressApiService();
}
