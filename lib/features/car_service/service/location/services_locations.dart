import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ServicesLocations {
  final Dio _dio;
  
  ServicesLocations(this._dio);

  Future<List<ServiceLocation>> getNearbyServices(double lat, double lng) async {
    try {
      final response = await _dio.get(
        '/get_nearby_services',
        queryParameters: {
          'lat': lat,
          'lng': lng,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> services = response.data['services'];
        return services
            .map((service) => ServiceLocation.fromJson(service))
            .toList();
      }
      throw Exception('Failed to fetch services');
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

@riverpod
ServicesLocations servicesLocations( ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,  // Replace with your URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
  
  return ServicesLocations(dio);
}