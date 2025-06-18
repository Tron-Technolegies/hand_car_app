import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/products/brand/brand_model.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/model/products/promoted_brands/promoted_brands_model.dart';
import 'package:hand_car/features/Accessories/model/products/promoted_products/promoted_products_model.dart';

class ProductsApiServices {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500,
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/json',
    },
  ));

// Fetch all products
  Future<List<ProductsModel>> getProducts() async {
    try {
      final response = await _dio.get('/view_products');
      log('Raw API response: ${response.data}');

      final List<dynamic> productList = response.data['product'];
      log('Product list: $productList');

      return productList.map((dynamic item) {
        // Convert the dynamic Map to Map<String, dynamic>
        final Map<String, dynamic> json =
            Map<String, dynamic>.from(item as Map);

        // Add default values for optional fields
        final modifiedJson = {
          ...json,
          'discount_percentage': json['discount_percentage'] ?? 0,
          'is_bestseller': json['is_bestseller'] ?? false,
          'description': json['description'] ?? '',
        };

        try {
          return ProductsModel.fromJson(modifiedJson);
        } catch (e) {
          log('Error parsing product: $e');
          log('Product data: $modifiedJson');
          rethrow;
        }
      }).toList();
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      log('Response: ${e.response?.data}');
      throw Exception('Failed to fetch products: ${e.message}');
    } catch (e, stack) {
      log('Error fetching products: $e');
      log('Stack trace: $stack');
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<List<PromotedBrandsModel>> getPromotedBrands() async {
    try {
      final response =
          await _dio.get('/view_promoted_brands'); // Adjust endpoint as needed
      final List<dynamic> data = response.data['promoted_products'];
      log('Promoted products data: $data');
      return data.map((json) => PromotedBrandsModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch promoted products: $e');
    }
  }

  //Promoted Products

  Future<List<PromotedProductsModel>> getPromotedProducts() async {
    try {
      final response = await _dio
          .get('/view_promoted_products'); // Adjust endpoint as needed
      final List<dynamic> data = response.data['promoted_products'];
      log('Promoted products data: $data');
      return data.map((json) => PromotedProductsModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch promoted products: $e');
    }
  }

  Future<List<ProductsModel>> getFilteredProducts(
      Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.get(
        '/view_products', // Use correct endpoint
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> productList = data['product']; // Correct key
        return productList.map((dynamic item) {
          final json = Map<String, dynamic>.from(item);
          final modifiedJson = {
            ...json,
            'discount_percentage': json['discount_percentage'] ?? 0,
            'is_bestseller': json['is_bestseller'] ?? false,
            'description': json['description'] ?? '',
          };
          return ProductsModel.fromJson(modifiedJson);
        }).toList();
      } else {
        throw Exception('Failed to fetch products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }


 Future<List<BrandModel>> getAllBrands() async {
  try {
    final response = await _dio.get('/view_brand');
    if (response.statusCode == 200) {
      log('API Response: ${response.data}');
      final data = response.data as Map<String, dynamic>;
      // FIX: Changed key from 'brand' to 'brands'
      final List<dynamic> brandList = data['brands']; 
      return brandList.map((dynamic item) {
        final json = Map<String, dynamic>.from(item);
        // FIX: Convert int id to String
        json['id'] = json['id'].toString(); 
        return BrandModel.fromJson(json);
      }).toList();
    } else {
      log('API Response: ${response.data}');
      throw Exception('Failed to fetch brands: ${response.statusMessage}');
    }
  } on DioException catch (e) {
    throw Exception('Dio error: ${e.message}');
  } catch (e) {
    throw Exception('Failed to fetch brands: $e');
  }
}
}
