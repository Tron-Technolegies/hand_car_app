import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_locations.g.dart';

class ServicesLocations {
  final Dio _dio;

  ServicesLocations(this._dio);

  Future<List<ServiceModel>> getNearbyServices({
  required double lat,
  required double lng,
  double radius = 10,
}) async {
  try {
    final response = await _dio.get(
      '/get_nearby_services',
      options: Options(
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        validateStatus: (status) => status! < 500, // Accept all responses below 500
      ),
      queryParameters: {
        'lat': lat,  // No need to convert to string, Dio handles this
        'lng': lng,
        'radius': radius,
      },
    );

    // Check if response is successful and has valid data
    if (response.statusCode == 200) {
      final services = response.data['services'] as List<dynamic>?;
      
      if (services == null || services.isEmpty) {
        return []; // Return empty list instead of throwing exception
      }

      return services
          .where((service) => service != null) // Filter out null services
          .map((service) {
            try {
              return ServiceModel.fromJson(service);
            } catch (e) {
              log('Error parsing service: $e');
              return null;
            }
          })
          .whereType<ServiceModel>() // Remove any null values from parsing errors
          .toList();
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Failed to fetch services: ${response.statusCode}',
    );

  } on DioException catch (e) {
    String errorMessage;
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        errorMessage = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Server is taking too long to respond. Please try again.';
        break;
      case DioExceptionType.badResponse:
        // Handle specific HTTP error codes
        if (e.response?.statusCode == 500) {
          errorMessage = 'Server error. Please try again later.';
        } else {
          errorMessage = 'Network error: ${e.response?.statusMessage ?? 'Unknown error'}';
        }
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection. Please check your network.';
        break;
      default:
        errorMessage = 'Network error: ${e.message}';
    }
    
    log('Service fetch error: $errorMessage');
    log('Error details: $e');
    throw Exception(errorMessage);
    
  } catch (e) {
    log('Unexpected error while fetching services: $e');
    throw Exception('Unexpected error occurred. Please try again.');
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
  ));

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