
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Authentication/service/login_service.dart';

class CartApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500, // Accept all status codes less than 500
  ));

  /// Get the cart items for the user.
  static Future<Map<String, dynamic>> getCart() async {
    try {
      // Retrieve the session ID
    final sessionId = await ApiServiceAuthentication.getSessionId();
    log('Session ID: $sessionId');
    if (sessionId == null) {
      return {'success': false, 'error': 'Not authenticated'};
      
    }

    // Set the session ID in the headers for the request
    final response = await _dio.get(
      '/viewcartitems/',
      options: Options(
        headers: {'Cookie': 'sessionid=$sessionId'},
      ),
    );

    return {
      'success': true,
      'cart': response.data['cart_items'],
      'total': response.data['total_price']
    };
  } on DioException catch (e) {
    return {'success': false, 'error': _handleDioError(e)};
  }
}
  
  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error ${e.response?.statusCode}: ${e.response?.data['error'] ?? 'Unknown error'}';
    }
    return 'Network error: ${e.message}';
  }
}