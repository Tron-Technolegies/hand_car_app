import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class ServiceLocation with _$ServiceLocation {
  const factory ServiceLocation({
    required String name,
    required double latitude,
    required double longitude,
    required double distance,
  }) = _ServiceLocation;

  factory ServiceLocation.fromJson(Map<String, dynamic> json) =>
      _$ServiceLocationFromJson(json);
}

// models/service_state.freezed.dart
@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState({
    @Default([]) List<ServiceLocation> services,
    @Default(false) bool isLoading,
    String? error,
  }) = _ServicesState;
}