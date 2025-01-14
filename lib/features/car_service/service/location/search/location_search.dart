import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/features/car_service/model/location/search_location/search_location.dart';

class LocationSearchService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://nominatim.openstreetmap.org',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'User-Agent': 'HandCar', // Required by Nominatim
    },
  ));

  Future<List<LocationSearchResult>> searchLocation(String query) async {
    try {
      final response = await _dio.get(
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
      log('Error searching locations: $e');
      return [];
    }
  }
}