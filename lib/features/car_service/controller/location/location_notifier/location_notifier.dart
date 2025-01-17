

import 'package:geolocator/geolocator.dart';
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
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location services are disabled. Please enable location services in your device settings.',
          isLocationEnabled: false,
        );
        return;
      }

      // Check location permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            isLoading: false,
            error: 'Location permissions are denied. Please enable them in your app settings.',
            isLocationEnabled: false,
          );
          return;
        }
      }

      // Handle permanently denied permissions
      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location permissions are permanently denied. Please enable them in your app settings.',
          isLocationEnabled: false,
        );
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
       locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      state = state.copyWith(
        position: position,
        isLoading: false,
        error: null,
        isLocationEnabled: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to get location: ${e.toString()}',
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

