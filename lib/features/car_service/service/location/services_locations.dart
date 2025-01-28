

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
    required double? lat,
    required double? lng,
  }) async {
    try {
      final response = await _dio.get(
        '/view_service_user',
        queryParameters: lat != null && lng != null
            ? {
                'lat': lat.toString(),
                'lng': lng.toString(),
              }
            : null,
      );

      if (response.statusCode == 200) {
        log('Response data: ${response.data}'); // Debug print
        
        final List<dynamic> servicesJson = response.data['services'] as List;
        
        return servicesJson.map((json) {
          try {
            log('Processing service: $json'); // Debug print
            return ServiceModel.fromJson(json);
          } catch (e, stackTrace) {
            log('Error parsing service: $e');
            log('Service data: $json');
            ('Stack trace: $stackTrace');
            rethrow;
          }
        }).toList();
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to fetch services: ${response.statusCode}',
      );
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      log('Response data: ${e.response?.data}');
      throw Exception('Failed to fetch services: ${e.message}');
    } catch (e, stackTrace) {
      log('Unexpected error: $e');
      log('Stack trace: $stackTrace');
      throw Exception('Unexpected error while fetching services: $e');
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