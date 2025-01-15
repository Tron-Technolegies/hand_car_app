// location_service.dart
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math' as math;

class LocationService {
  final Dio _dio = Dio();
  final String _apiKey = 'f95c2a61235f4365a6f22eb79ce8446a';

  // Get current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }

  // Get address from coordinates using Geocoding package
  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.country}'.replaceAll(RegExp(r'null,?\s*'), '').trim();
      }
      return '';
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }

  // Get coordinates from address using OpenCage (to match backend)
  Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      final response = await _dio.get(
        'https://api.opencagedata.com/geocode/v1/json',
        queryParameters: {
          'q': address,
          'key': _apiKey,
        },
      );

      if (response.data['results'] != null && 
          response.data['results'].isNotEmpty) {
        final result = response.data['results'][0];
        final geometry = result['geometry'];
        
        return Position(
          latitude: geometry['lat'],
          longitude: geometry['lng'],
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get coordinates: $e');
    }
  }

  // Calculate distance using Haversine formula (to match backend)
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Radius of the Earth in kilometers
    
    // Convert latitude and longitude to radians
    final lat1Rad = _toRadians(lat1);
    final lon1Rad = _toRadians(lon1);
    final lat2Rad = _toRadians(lat2);
    final lon2Rad = _toRadians(lon2);
    
    // Calculate differences
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;
    
    // Haversine formula
    final a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1Rad) * math.cos(lat2Rad) * 
        math.pow(math.sin(dLon / 2), 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    
    // Calculate distance
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * math.pi / 180;
  }}