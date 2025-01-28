

import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/service/car_service_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'car_service_controller.g.dart';

@riverpod
class CarServiceController extends _$CarServiceController {
  
  late final CarServiceApiService _service;

  @override
  Future<List<ServiceModel>> build() async {
    _service = CarServiceApiService(baseUrl: baseUrl);
    return _fetchServices();
  }

  Future<List<ServiceModel>> _fetchServices() async {
    try {
      return await _service.getNearbyServices();
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

}