import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';
import 'package:latlong2/latlong.dart';

class LocationSearchService {
  static const int _minSearchLength = 5;
  static const Duration _debounceTime = Duration(milliseconds: 500);
  Timer? _debounceTimer;

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

  // Debounced search function
  Future<List<LocationSearchResult>> searchLocation(
    String query,
    Function(bool) onLoading,
  ) async {
    // Cancel any pending timer
    _debounceTimer?.cancel();

    // Return empty list if query is too short
    if (query.length < _minSearchLength) {
      return [];
    }

    // Set loading state
    onLoading(true);

    // Create new debounce timer
    return await Future.delayed(Duration.zero, () {
      final completer = Completer<List<LocationSearchResult>>();

      _debounceTimer = Timer(_debounceTime, () async {
        try {
          final results = await _performSearch(query);
          completer.complete(results);
        } catch (e) {
          log('Search error: $e');
          completer.complete([]);
        } finally {
          onLoading(false);
        }
      });

      return completer.future;
    });
  }

  // Perform the actual search
  Future<List<LocationSearchResult>> _performSearch(String query) async {
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
      return _fallbackToOpenCage(query);
    } catch (e) {
      log('Error searching locations with Nominatim: $e');
      return _fallbackToOpenCage(query);
    }
  }

  // Fallback to OpenCage with cache
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

  // Geocode with caching
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

  // Clean up resources
  void dispose() {
    _debounceTimer?.cancel();
  }
}