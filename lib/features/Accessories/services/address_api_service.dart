import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';

class AddressApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String?> _getToken() async {
    return TokenStorage().getAccessToken();
  }

  Future<List<Map<String, dynamic>>> getAddresses() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    try {
      final response = await _dio.get(
        '/view_addresses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Ensure we're returning a List<Map<String, dynamic>>
        final List<dynamic> addressList = response.data['addresses'] ?? [];
        return addressList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to fetch addresses');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['error'] ?? 'Failed to fetch addresses');
      }
      throw Exception('Failed to connect to server');
    }
  }

  Future<Map<String, dynamic>> addAddress({
    required String street,
    required String country,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    try {
      final response = await _dio.post(
        '/add_address',
        data: {
          'street': street,
          'country': country,
          'city': city,
          'state': state,
          'zip_code': zipCode,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add address');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['error'] ?? 'Failed to add address');
      }
      throw Exception('Failed to connect to server');
    }
  }
}