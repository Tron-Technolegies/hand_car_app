
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hand_car/features/car_service/model/location/location_state/location_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


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
        throw Exception('Location services are disabled');
      }

      // Check location permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final address = '${place.street}, ${place.locality}, ${place.country}';
        state = state.copyWith(
          position: position,
          address: address,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}