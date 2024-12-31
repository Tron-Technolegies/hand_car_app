import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/address/address_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_api_service.g.dart';

@riverpod
AddressService addressApiService( ref) {
  final dio = ref.watch(dioProvider);
  return AddressService(dio);
}

@riverpod
Dio dio( ref) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl; // Replace with your API base URL
  return dio;
}

class AddressService {
  final Dio _dio;

  AddressService(this._dio);

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _dio.get('/view_addresses');
      return (response.data['addresses'] as List)
          .map((json) => AddressModel.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<AddressModel> addAddress({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    try {
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
      );
      return AddressModel.fromJson(response.data['address']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<AddressModel> updateAddress({
    required int id,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    try {
      final response = await _dio.put(
        '/api/addresses/$id/',
        data: {
          'street': street,
          'city': city,
          'state': state,
          'zip_code': zipCode,
          'country': country,
          'is_default': isDefault,
        },
      );
      return AddressModel.fromJson(response.data['address']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      await _dio.delete('/api/addresses/$id/');
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      if (response != null) {
        return response.data['message'] ?? 'An error occurred';
      }
      return error.message ?? 'Network error occurred';
    }
    return error.toString();
  }
}
