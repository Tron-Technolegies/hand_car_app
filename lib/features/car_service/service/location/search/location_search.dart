import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';
import 'package:latlong2/latlong.dart';

class LocationSearchService {
  // Nominatim client for location search
  final _nominatimDio = Dio(BaseOptions(
    baseUrl: 'https://nominatim.openstreetmap.org',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'User-Agent': 'HandCar', // Required by Nominatim
    },
  ));

  // OpenCage client for geocoding
  final _openCageDio = Dio(BaseOptions(
    baseUrl: 'https://api.opencagedata.com/geocode/v1',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  final String _openCageApiKey = 'f95c2a61235f4365a6f22eb79ce8446a';

  // Search locations using Nominatim
  Future<List<LocationSearchResult>> searchLocation(String query) async {
    try {
      final response = await _nominatimDio.get(
        '/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': 5,
          'addressdetails': 1,
        },
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => LocationSearchResult.fromNominatim(json))
            .toList();
      }

      log('Search failed: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Error searching locations with Nominatim: $e');
      return _fallbackToOpenCage(query);
    }
  }

  // Fallback to OpenCage if Nominatim fails
  Future<List<LocationSearchResult>> _fallbackToOpenCage(String query) async {
    try {
      final response = await _openCageDio.get(
        '/json',
        queryParameters: {
          'q': query,
          'key': _openCageApiKey,
          'limit': 5,
        },
      );

      if (response.statusCode == 200 && response.data['results'] != null) {
        return (response.data['results'] as List).map((result) {
          final geometry = result['geometry'];
          final components = result['components'];
          
          return LocationSearchResult(
            displayName: result['formatted'] ?? '',
            latLng: LatLng(
              geometry['lat'].toDouble(),
              geometry['lng'].toDouble(),
            ),
            type: components['type'],
            address: components['road'] ?? components['locality'] ?? '',
          );
        }).toList();
      }

      log('OpenCage search failed: ${response.statusCode}');
      return [];
    } catch (e) {
      log('Error searching locations with OpenCage: $e');
      return [];
    }
  }

  // Geocode a specific address using OpenCage
  Future<(double?, double?)?> geocodeAddress(String address) async {
    try {
      final response = await _openCageDio.get(
        '/json',
        queryParameters: {
          'q': address,
          'key': _openCageApiKey,
        },
      );

      if (response.statusCode == 200 && 
          response.data['results'] != null && 
          response.data['results'].isNotEmpty) {
        final result = response.data['results'][0];
        final geometry = result['geometry'];
        final lat = geometry['lat'] as num;
        final lng = geometry['lng'] as num;
        
        return (lat.toDouble(), lng.toDouble());
      }
      return null;
    } catch (e) {
      log('Error geocoding address with OpenCage: $e');
      return null;
    }
  }
}