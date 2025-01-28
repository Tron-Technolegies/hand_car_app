import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';

class CarServiceApiService {
  final Dio _dio;
  final String baseUrl;

  CarServiceApiService({required this.baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

  Future<List<ServiceModel>> getNearbyServices({
    double? lat,
    double? lng,
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
        log('API Response: ${response.data}');
        final List<dynamic> servicesJson = response.data['services'] as List;
        return servicesJson.map((json) => ServiceModel.fromJson(json)).toList();
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to fetch services: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        log('Invalid location coordinates provided');
        throw Exception('Invalid location coordinates provided');
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Connection timeout. Please check your internet connection.');
      }

      throw Exception('Failed to fetch services: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching services: $e');
    }
  }
}
