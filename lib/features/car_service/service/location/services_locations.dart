import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_locations.g.dart';

class ServicesLocations {
  final Dio _dio;
  
  ServicesLocations(this._dio);

  Future<List<ServiceLocation>> getNearbyServices(double lat, double lng) async {
    try {
      final response = await _dio.get(
        '/get_nearby_services',
        queryParameters: {
          'lat': lat.toString(), // Convert to string to match backend
          'lng': lng.toString(), // Convert to string to match backend
        },
      );

      if (response.statusCode == 200 && response.data['services'] != null) {
        final List<dynamic> services = response.data['services'];
        return services.map((service) {
          // Match the backend response structure
          return ServiceLocation(
            name: service['vendor_name'] as String,
 
            // Convert distance to double and round to 2 decimal places
            distance: double.parse((service['distance'] as num).toStringAsFixed(2)),
            // Since the backend doesn't return these, we'll set them to 0
            latitude: 0,
            longitude: 0,
          );
        }).toList();
      }
      throw Exception('Failed to fetch services');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server is taking too long to respond. Please try again.');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

@riverpod
ServicesLocations servicesLocations( ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    validateStatus: (status) {
      return status != null && status < 500;
    },
  ));
  
  // Add interceptors for logging in debug mode
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));
  
  return ServicesLocations(dio);
}