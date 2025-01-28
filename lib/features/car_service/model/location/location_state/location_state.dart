import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.freezed.dart'; 


@freezed

class LocationState with _$LocationState {
  const factory LocationState({
    Position? position,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isLocationEnabled,
  }) = _LocationState;
}