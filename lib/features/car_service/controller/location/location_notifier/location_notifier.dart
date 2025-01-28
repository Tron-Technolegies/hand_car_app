

import 'package:geolocator/geolocator.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/car_service/model/location/location_state/location_state.dart';

part 'location_notifier.g.dart';


@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  LocationState build() => const LocationState();

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location services are disabled. Please enable location services.',
          isLocationEnabled: false,
        );
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            isLoading: false,
            error: 'Location permissions are denied.',
            isLocationEnabled: false,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location permissions are permanently denied.',
          isLocationEnabled: false,
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      
      state = state.copyWith(
        position: position,
        isLoading: false,
        isLocationEnabled: true,
      );

      // Fetch nearby services with new location
      await ref.read(servicesNotifierProvider.notifier).fetchNearbyServices(
        position.latitude,
        position.longitude,
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to get location: $e',
        isLocationEnabled: false,
      );
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
