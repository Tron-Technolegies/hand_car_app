// lib/features/car_service/controller/location/location_list/location_list.dart
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/service/location/services_locations.dart';
import 'package:hand_car/features/car_service/service/location/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_list.g.dart';

@riverpod
class ServicesNotifier extends _$ServicesNotifier {
  final _locationService = LocationService();
  bool _isLoading = false;

  @override
  ServicesState build() => ServicesState();

  Future<void> fetchNearbyServices(double lat, double lng) async {
    if (_isLoading) return;
    _isLoading = true;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(servicesLocationsProvider);
      final services = await repository.getNearbyServices(lat: lat, lng: lng);
      
      // Calculate distances for all services
      final servicesWithDistances = services.map((service) {
        if (service.latitude != null && service.longitude != null) {
          final distance = _locationService.calculateDistance(
            lat,
            lng,
            service.latitude!,
            service.longitude!
          );
          return service.copyWith(distance: distance);
        }
        return service;
      }).toList();

      // Sort by distance
      servicesWithDistances.sort((a, b) {
        final distanceA = a.distance ?? double.infinity;
        final distanceB = b.distance ?? double.infinity;
        return distanceA.compareTo(distanceB);
      });

      state = state.copyWith(
        services: servicesWithDistances,
        isLoading: false,
      );
    } catch (e) {
      print('Error fetching services: $e');
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

  List<ServiceModel> getServicesWithinRadius(double radius) {
    return state.services.where((service) {
      return service.distance != null && service.distance! <= radius;
    }).toList();
  }
}