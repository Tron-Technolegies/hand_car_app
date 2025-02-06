// location_search_result.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'search_location.freezed.dart';

@freezed
class LocationSearchResult with _$LocationSearchResult {
  const factory LocationSearchResult({
    required String displayName,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required LatLng latLng,
    String? type,
    String? address,
  }) = _LocationSearchResult;

  factory LocationSearchResult.fromJson(Map<String, dynamic> json) {
    return LocationSearchResult(
      displayName: json['display_name'] ?? '',
      latLng: LatLng(
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
      type: json['type'],
      address: json['address']?['road'],
    );
  }

  // Custom fromNominatim factory
  factory LocationSearchResult.fromNominatim(Map<String, dynamic> json) {
    return LocationSearchResult(
      displayName: json['display_name'] ?? '',
      latLng: LatLng(
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
      type: json['type'],
      address: json['address']?['road'],
    );
  }
}

// Custom JSON converter for LatLng
class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      json['latitude'] as double,
      json['longitude'] as double,
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng latLng) {
    return {
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    };
  }
}
