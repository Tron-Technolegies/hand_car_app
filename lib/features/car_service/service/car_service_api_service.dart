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

  Future<List<ServiceModel>> getService() async {
    try {
      final response = await _dio.get('/view_service_user');
      if (response.statusCode == 200) {
        final List<dynamic> serviceList = response.data['services'] ?? [];
        log('Service list: $serviceList');
        return serviceList.map((data) {
          try {
            return ServiceModel.fromJson(data);
          } catch (e) {
            log('Error parsing service: $e');
            // Return a default service model if parsing fails
            return const ServiceModel(
              id: 0,
              vendorName: 'Unknown',
              phoneNumber: '',
              whatsappNumber: '',
              serviceDetails: '',
              address: '',
              rate: 0.0,
            );
          }
        }).toList();
      }
      throw Exception('Failed to fetch services');
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }
}


