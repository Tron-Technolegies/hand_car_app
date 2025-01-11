

import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/service/car_service_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'car_service_controller.g.dart';

@riverpod
class CarServiceController extends _$CarServiceController {
  
  late final CarServiceApiService _service ;

  Future<List<ServiceModel>> build() async {
    _service = CarServiceApiService();
    return fetchServices();
  }
  Future<List<ServiceModel>> fetchServices() async {
    return _service.getService();
  }
Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final response = await _service.getService();
      state = AsyncValue.data(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}