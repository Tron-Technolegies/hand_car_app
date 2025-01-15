import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:hand_car/features/car_service/service/location/services_locations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_list.g.dart';

@riverpod
class ServicesNotifier extends _$ServicesNotifier {
  @override
   bool _isLoading = false;

  @override
  ServicesState build() => const ServicesState();

  Future<void> fetchNearbyServices(double lat, double lng) async {
    if (_isLoading) return; // Prevent multiple simultaneous requests
    
    _isLoading = true;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(servicesLocationsProvider);
      final services = await repository.getNearbyServices(lat, lng);
      
      state = state.copyWith(
        services: services,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch nearby services: ${e.toString()}',
      );
    } finally {
      _isLoading = false;
    }
  }

  void clearServices() {
    state = state.copyWith(
      services: [],
      error: null,
      isLoading: false,
    );
    _isLoading = false;
  }
}