import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';

class AddressApiService {
  static final Dio _dio=Dio(
    
    BaseOptions(
    
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  Future<String?> _getToken() async {
    return TokenStorage().getAccessToken(); // Fetch token from local storage
  }

  Future<Map<String, dynamic>> addAddress({
    required String address,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    final token = await _getToken(); // Retrieve the access token
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    try {
      final response = await _dio.post('/add_address',
          data: FormData.fromMap(
            {
              'address': address,
              'city': city,
              'state': state,
              'zipCode': zipCode,
            },
          ),
          options: Options(headers: {'Authorization': 'Bearer $token'}));

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