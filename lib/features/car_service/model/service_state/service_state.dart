
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';

part 'service_state.freezed.dart';

@freezed
class CarServiceState with _$CarServiceState {
  const factory CarServiceState({
    @Default([]) List<ServiceModel> services,
    @Default(false) bool isLoading,
    String? error,
  }) = _CarServiceState;
}