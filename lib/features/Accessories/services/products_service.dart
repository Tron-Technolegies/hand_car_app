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

  // Helper method to generate a timestamp for logs
  String _getTimestamp() => DateTime.now().toIso8601String();

  // Fetch all products
  Future<List<ProductsModel>> getProducts() async {
    const String endpoint = '/view_products';
    log('[$_getTimestamp()] Starting fetch products from $endpoint', name: 'ProductsApiServices');
    
    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}', name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}', name: 'ProductsApiServices');

      final List<dynamic> productList = response.data['product'];
      log('[$_getTimestamp()] Product list count: ${productList.length}', name: 'ProductsApiServices');

      return productList.asMap().entries.map((entry) {
        final index = entry.key;
        final dynamic item = entry.value;
        final Map<String, dynamic> json = Map<String, dynamic>.from(item as Map);
        log('[$_getTimestamp()] Processing product #$index: $json', name: 'ProductsApiServices');

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
          log('[$_getTimestamp()] Error parsing product #$index: $e', name: 'ProductsApiServices', error: e);
          log('[$_getTimestamp()] Problematic product data: $modifiedJson', name: 'ProductsApiServices');
          rethrow;
        }
      }).toList();
    } on DioException catch (e) {
      log('[$_getTimestamp()] Dio error fetching products from $endpoint: ${e.message}', 
          name: 'ProductsApiServices', 
          error: e,
          stackTrace: e.stackTrace);
      log('[$_getTimestamp()] Response data: ${e.response?.data}', name: 'ProductsApiServices');
      throw Exception('Failed to fetch products: ${e.message}');
    } catch (e, stack) {
      log('[$_getTimestamp()] Unexpected error fetching products from $endpoint: $e', 
          name: 'ProductsApiServices', 
          error: e, 
          stackTrace: stack);
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Fetch promoted brands
  Future<List<PromotedBrandsModel>> getPromotedBrands() async {
    const String endpoint = '/view_promoted_brands';
    log('[$_getTimestamp()] Starting fetch promoted brands from $endpoint', name: 'ProductsApiServices');
    
    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}', name: 'ProductsApiServices');
      final List<dynamic> data = response.data['promoted_products'];
      log('[$_getTimestamp()] Promoted brands count: ${data.length}', name: 'ProductsApiServices');
      log('[$_getTimestamp()] Promoted brands data: $data', name: 'ProductsApiServices');

      return data.asMap().entries.map((entry) {
        final index = entry.key;
        final json = entry.value;
        try {
          return PromotedBrandsModel.fromJson(json);
        } catch (e) {
          log('[$_getTimestamp()] Error parsing promoted brand #$index: $e', 
              name: 'ProductsApiServices', 
              error: e);
          rethrow;
        }
      }).toList();
    } catch (e, stack) {
      log('[$_getTimestamp()] Error fetching promoted brands from $endpoint: $e', 
          name: 'ProductsApiServices', 
          error: e, 
          stackTrace: stack);
      throw Exception('Failed to fetch promoted brands: $e');
    }
  }

  // Fetch promoted products
  Future<List<PromotedProductsModel>> getPromotedProducts() async {
    const String endpoint = '/view_promoted_products';
    log('[$_getTimestamp()] Starting fetch promoted products from $endpoint', name: 'ProductsApiServices');
    
    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}', name: 'ProductsApiServices');
      final List<dynamic> data = response.data['promoted_products'];
      log('[$_getTimestamp()] Promoted products count: ${data.length}', name: 'ProductsApiServices');
      log('[$_getTimestamp()] Promoted products data: $data', name: 'ProductsApiServices');

      return data.asMap().entries.map((entry) {
        final index = entry.key;
        final json = entry.value;
        try {
          return PromotedProductsModel.fromJson(json);
        } catch (e) {
          log('[$_getTimestamp()] Error parsing promoted product #$index: $e', 
              name: 'ProductsApiServices', 
              error: e);
          rethrow;
        }
      }).toList();
    } catch (e, stack) {
      log('[$_getTimestamp()] Error fetching promoted products from $endpoint: $e', 
          name: 'ProductsApiServices', 
          error: e, 
          stackTrace: stack);
      throw Exception('Failed to fetch promoted products: $e');
    }
  }

  // Fetch filtered products
  Future<List<ProductsModel>> getFilteredProducts(Map<String, dynamic> queryParams) async {
    const String endpoint = '/view_products';
    log('[$_getTimestamp()] Starting fetch filtered products from $endpoint with params: $queryParams', 
        name: 'ProductsApiServices');
    
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}', name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}', name: 'ProductsApiServices');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> productList = data['product'];
        log('[$_getTimestamp()] Filtered product list count: ${productList.length}', name: 'ProductsApiServices');

        return productList.asMap().entries.map((entry) {
          final index = entry.key;
          final dynamic item = entry.value;
          final json = Map<String, dynamic>.from(item);
          log('[$_getTimestamp()] Processing filtered product #$index: $json', name: 'ProductsApiServices');

          final modifiedJson = {
            ...json,
            'discount_percentage': json['discount_percentage'] ?? 0,
            'is_bestseller': json['is_bestseller'] ?? false,
            'description': json['description'] ?? '',
          };

          try {
            return ProductsModel.fromJson(modifiedJson);
          } catch (e) {
            log('[$_getTimestamp()] Error parsing filtered product #$index: $e', 
                name: 'ProductsApiServices', 
                error: e);
            log('[$_getTimestamp()] Problematic product data: $modifiedJson', name: 'ProductsApiServices');
            rethrow;
          }
        }).toList();
      } else {
        log('[$_getTimestamp()] Failed to fetch filtered products: ${response.statusMessage}', 
            name: 'ProductsApiServices');
        throw Exception('Failed to fetch products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log('[$_getTimestamp()] Dio error fetching filtered products from $endpoint: ${e.message}', 
          name: 'ProductsApiServices', 
          error: e,
          stackTrace: e.stackTrace);
      throw Exception('Dio error: ${e.message}');
    }
  }

  // Fetch all brands
  Future<List<BrandModel>> getAllBrands() async {
    const String endpoint = '/view_brand';
    log('[$_getTimestamp()] Starting fetch brands from $endpoint', name: 'ProductsApiServices');
    
    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}', name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}', name: 'ProductsApiServices');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> brandList = data['brands'];
        log('[$_getTimestamp()] Brand list count: ${brandList.length}', name: 'ProductsApiServices');

        return brandList.asMap().entries.map((entry) {
          final index = entry.key;
          final dynamic item = entry.value;
          final json = Map<String, dynamic>.from(item);
          json['id'] = json['id'].toString();
          log('[$_getTimestamp()] Processing brand #$index: $json', name: 'ProductsApiServices');

          try {
            return BrandModel.fromJson(json);
          } catch (e) {
            log('[$_getTimestamp()] Error parsing brand #$index: $e', 
                name: 'ProductsApiServices', 
                error: e);
            rethrow;
          }
        }).toList();
      } else {
        log('[$_getTimestamp()] Failed to fetch brands: ${response.statusMessage}', 
            name: 'ProductsApiServices');
        throw Exception('Failed to fetch brands: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log('[$_getTimestamp()] Dio error fetching brands from $endpoint: ${e.message}', 
          name: 'ProductsApiServices', 
          error: e,
          stackTrace: e.stackTrace);
      throw Exception('Dio error: ${e.message}');
    } catch (e, stack) {
      log('[$_getTimestamp()] Unexpected error fetching brands from $endpoint: $e', 
          name: 'ProductsApiServices', 
          error: e, 
          stackTrace: stack);
      throw Exception('Failed to fetch brands: $e');
    }
  }
}