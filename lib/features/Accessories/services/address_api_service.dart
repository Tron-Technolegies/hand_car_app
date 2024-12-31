import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/exception/address/address_exception.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/address/address_model.dart';
import 'package:hand_car/features/Accessories/model/address/address_response.dart';

class AddressApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      validateStatus: (status) => status != null && status < 500,
      followRedirects: true,
      maxRedirects: 5,
    ),
  );

  Map<String, String> _createAuthHeaders(String token) {
    final tokenValue = token.startsWith('Bearer ') ? token : 'Bearer $token';
    return {
      'Authorization': tokenValue,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<T> _makeAuthenticatedRequest<T>(
      Future<T> Function(String token) request) async {
    try {
      // Check token expiration first
      if (TokenStorage().isAccessTokenExpired()) {
        log('Access token expired, attempting refresh');
        final refreshSuccess = await _refreshToken();
        if (!refreshSuccess) {
          throw AddressException('Session expired. Please login again.');
        }
      }

      final token = await _getToken();
      try {
        return await request(token);
      } on DioException catch (e) {
        log('DioException in request: ${e.message}');
        log('Response status: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');

        if (e.response?.statusCode == 401 ||
            (e.response?.data != null &&
                e.response?.data['code'] == 'token_not_valid')) {
          log('Token invalid, attempting refresh');
          final refreshSuccess = await _refreshToken();
          if (refreshSuccess) {
            final newToken = await _getToken();
            return await request(newToken);
          }
          throw AddressException('Session expired. Please login again.');
        }

        final errorMessage = e.response?.data?['detail']?.toString() ??
            e.response?.data?['error']?.toString() ??
            'An error occurred';
        throw AddressException(errorMessage);
      }
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      if (e is AddressException) rethrow;
      throw AddressException(e.toString());
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = TokenStorage().getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        log('No refresh token available');
        return false;
      }

      log('Attempting token refresh');
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      log('Refresh token response: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['access']?.toString();
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await TokenStorage().saveTokens(
            accessToken: newAccessToken,
            refreshToken: refreshToken,
          );
          log('Token refresh successful');
          return true;
        }
      }

      log('Token refresh failed: ${response.data}');
      return false;
    } catch (e) {
      log('Token refresh error: $e');
      return false;
    }
  }

  Future<String> _getToken() async {
    final token = TokenStorage().getAccessToken();
    if (token == null || token.isEmpty) {
      throw AddressException('Please login to continue');
    }
    return token;
  }

  Future<List<AddressModel>> getAddresses() async {
    return _makeAuthenticatedRequest((token) async {
      log('Fetching addresses');
      final response = await _dio.get(
        '/view_addresses',
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Addresses response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is! Map<String, dynamic>) {
          throw AddressException('Invalid response format');
        }

        final addressesData = response.data['addresses'] as List;

        return addressesData
            .map((json) =>
                AddressModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      }

      throw AddressException(
          response.data['error']?.toString() ?? 'Failed to fetch addresses');
    });
  }

  Future<AddressResponse> addAddress({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    return _makeAuthenticatedRequest((token) async {
      log('Adding new address');

      final response = await _dio.post(
        '/add_address',
        data: {
          'street': street,
          'city': city,
          'state': state,
          'zip_code': zipCode,
          'country': country,
          'is_default': isDefault,
        },
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Add address response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddressResponse(
          message: response.data['message'] as String? ??
              'Address added successfully',
          address:
              AddressModel.fromJson(response.data['address'] ?? response.data),
          isSuccess: true,
        );
      }

      throw AddressException(
          response.data['error']?.toString() ?? 'Failed to add address');
    });
  }

  Future<AddressResponse> updateAddress({
    required int id,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    return _makeAuthenticatedRequest((token) async {
      log('Updating address: $id');

      final response = await _dio.put(
        '/update_address/$id/',
        data: {
          'street': street,
          'city': city,
          'state': state,
          'zip_code': zipCode,
          'country': country,
          'is_default': isDefault,
        },
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Update address response: ${response.data}');

      if (response.statusCode == 200) {
        return AddressResponse(
          message: response.data['message'] as String? ??
              'Address updated successfully',
          address:
              AddressModel.fromJson(response.data['address'] ?? response.data),
          isSuccess: true,
        );
      }

      throw AddressException(
          response.data['error']?.toString() ?? 'Failed to update address');
    });
  }

  Future<AddressResponse> deleteAddress(int id) async {
    return _makeAuthenticatedRequest((token) async {
      log('Deleting address: $id');

      final response = await _dio.delete(
        '/delete_address/$id/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Delete address response: ${response.data}');

      if (response.statusCode == 200) {
        return AddressResponse(
          message: response.data['message'] as String? ??
              'Address deleted successfully',
          isSuccess: true,
        );
      }

      throw AddressException(
          response.data['error']?.toString() ?? 'Failed to delete address');
    });
  }

  Future<AddressModel> setDefaultAddress(int id) async {
    return _makeAuthenticatedRequest((token) async {
      log('Setting default address: $id');

      final response = await _dio.post(
        '/set_default_address/$id/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Set default address response: ${response.data}');

      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data['address'] ?? response.data);
      }

      throw AddressException(response.data['error']?.toString() ??
          'Failed to set default address');
    });
  }
}
