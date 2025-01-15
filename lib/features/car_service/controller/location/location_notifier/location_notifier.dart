
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
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
        throw Exception('Please enable location services');
      }

      // Check and request location permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied. Please enable them in settings.');
      }

      // Get current position with high accuracy
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );

      // Get detailed address information
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final address = _formatAddress(place);
        
        state = state.copyWith(
          position: position,
          address: address,
          isLoading: false,
        );

        // Fetch nearby services after getting location
        ref.read(servicesNotifierProvider.notifier).fetchNearbyServices(
          position.latitude,
          position.longitude,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  String _formatAddress(Placemark place) {
    final components = <String>[];
    
    if (place.street?.isNotEmpty ?? false) components.add(place.street!);
    if (place.locality?.isNotEmpty ?? false) components.add(place.locality!);
    if (place.country?.isNotEmpty ?? false) components.add(place.country!);
    
    return components.join(', ');
  }
}
