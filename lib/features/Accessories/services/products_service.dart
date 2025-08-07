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

  String _getTimestamp() => DateTime.now().toIso8601String();

  // Fetch paginated products
  Future<Map<String, dynamic>> getProducts({int page = 1, int limit = 10}) async {
    const String endpoint = '/view_products';
    log('[$_getTimestamp()] Starting fetch products from $endpoint (page: $page, limit: $limit)',
        name: 'ProductsApiServices');

    try {
      final response = await _dio.get(endpoint, queryParameters: {
        'page': page,
        'limit': limit,
      });
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}',
          name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}',
          name: 'ProductsApiServices');

      final Map<String, dynamic> responseData = response.data;
      final List<dynamic> productList = responseData['products'] ?? [];
      log('[$_getTimestamp()] Product list count: ${productList.length}',
          name: 'ProductsApiServices');

      final products = productList.asMap().entries.map((entry) {
        final index = entry.key;
        final dynamic item = entry.value;
        final Map<String, dynamic> json = Map<String, dynamic>.from(item);
        log('[$_getTimestamp()] Processing product #$index: $json',
            name: 'ProductsApiServices');

        final modifiedJson = {
          ...json,
          'discount_percentage': json['discount_percentage'] ?? 0,
          'is_bestseller': json['is_bestseller'] ?? false,
          'description': json['description'] ?? '',
        };

        try {
          return ProductsModel.fromJson(modifiedJson);
        } catch (e) {
          log('[$_getTimestamp()] Error parsing product #$index: $e',
              name: 'ProductsApiServices', error: e);
          log('[$_getTimestamp()] Problematic product data: $modifiedJson',
              name: 'ProductsApiServices');
          rethrow;
        }
      }).toList();

      return {
        'products': products,
        'total': responseData['total'] ?? 0,
        'page': responseData['page'] ?? page,
        'pages': responseData['pages'] ?? 1,
        'has_next': responseData['has_next'] ?? false,
        'has_previous': responseData['has_previous'] ?? false,
      };
    } on DioException catch (e) {
      log('[$_getTimestamp()] Dio error fetching products from $endpoint: ${e.message}',
          name: 'ProductsApiServices', error: e, stackTrace: e.stackTrace);
      throw Exception('Failed to fetch products: ${e.message}');
    } catch (e, stack) {
      log('[$_getTimestamp()] Unexpected error fetching products from $endpoint: $e',
          name: 'ProductsApiServices', error: e, stackTrace: stack);
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Fetch filtered paginated products
  Future<Map<String, dynamic>> getFilteredProducts(
      Map<String, dynamic> queryParams, {int page = 1, int limit = 10}) async {
    const String endpoint = '/view_products';
    final params = {
      ...queryParams,
      'page': page,
      'limit': limit,
    };
    log('[$_getTimestamp()] Starting fetch filtered products from $endpoint with params: $params',
        name: 'ProductsApiServices');

    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}',
          name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}',
          name: 'ProductsApiServices');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> productList = responseData['products'] ?? [];
        log('[$_getTimestamp()] Filtered product list count: ${productList.length}',
            name: 'ProductsApiServices');

        final products = productList.asMap().entries.map((entry) {
          final index = entry.key;
          final dynamic item = entry.value;
          final json = Map<String, dynamic>.from(item);
          log('[$_getTimestamp()] Processing filtered product #$index: $json',
              name: 'ProductsApiServices');

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
                name: 'ProductsApiServices', error: e);
            log('[$_getTimestamp()] Problematic product data: $modifiedJson',
                name: 'ProductsApiServices');
            rethrow;
          }
        }).toList();

        return {
          'products': products,
          'total': responseData['total'] ?? 0,
          'page': responseData['page'] ?? page,
          'pages': responseData['pages'] ?? 1,
          'has_next': responseData['has_next'] ?? false,
          'has_previous': responseData['has_previous'] ?? false,
        };
      } else {
        log('[$_getTimestamp()] Failed to fetch filtered products: ${response.statusMessage}',
            name: 'ProductsApiServices');
        throw Exception('Failed to fetch products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log('[$_getTimestamp()] Dio error fetching filtered products from $endpoint: ${e.message}',
          name: 'ProductsApiServices', error: e, stackTrace: e.stackTrace);
      throw Exception('Dio error: ${e.message}');
    }
  }

  // Fetch promoted brands (unchanged)
  Future<List<PromotedBrandProductModel>> getPromotedBrands() async {
    const String endpoint = '/promoted_brands_products';
    log('[$_getTimestamp()] Starting fetch promoted brands products from $endpoint',
        name: 'ProductsApiServices');

    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}',
          name: 'ProductsApiServices');

      final List<dynamic> data = response.data['promoted_brands_products'] ?? [];
      log('[$_getTimestamp()] Promoted brands products count: ${data.length}',
          name: 'ProductsApiServices');
      log('[$_getTimestamp()] Promoted brands products data: $data',
          name: 'ProductsApiServices');

      return data.asMap().entries.map((entry) {
        final index = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        try {
          return PromotedBrandProductModel.fromJson(json);
        } catch (e) {
          log('[$_getTimestamp()] Error parsing promoted brand product #$index: $e',
              name: 'ProductsApiServices', error: e);
          rethrow;
        }
      }).toList();
    } catch (e, stack) {
      log('[$_getTimestamp()] Error fetching promoted brands products from $endpoint: $e',
          name: 'ProductsApiServices', error: e, stackTrace: stack);
      return [];
    }
  }

  // Fetch promoted products (unchanged)
  Future<List<PromotedProductsModel>> getPromotedProducts() async {
    const String endpoint = '/view_promoted_products';
    log('[$_getTimestamp()] Starting fetch promoted products from $endpoint',
        name: 'ProductsApiServices');

    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}',
          name: 'ProductsApiServices');
      final List<dynamic> data = response.data['promoted_products'];
      log('[$_getTimestamp()] Promoted products count: ${data.length}',
          name: 'ProductsApiServices');
      log('[$_getTimestamp()] Promoted products data: $data',
          name: 'ProductsApiServices');

      return data.asMap().entries.map((entry) {
        final index = entry.key;
        final json = entry.value;
        try {
          return PromotedProductsModel.fromJson(json);
        } catch (e) {
          log('[$_getTimestamp()] Error parsing promoted product #$index: $e',
              name: 'ProductsApiServices', error: e);
          rethrow;
        }
      }).toList();
    } catch (e, stack) {
      log('[$_getTimestamp()] Error fetching promoted products from $endpoint: $e',
          name: 'ProductsApiServices', error: e, stackTrace: stack);
      throw Exception('Failed to fetch promoted products: $e');
    }
  }

  // Fetch all brands (unchanged)
  Future<List<BrandModel>> getAllBrands() async {
    const String endpoint = '/view_brand';
    log('[$_getTimestamp()] Starting fetch brands from $endpoint',
        name: 'ProductsApiServices');
    try {
      final response = await _dio.get(endpoint);
      log('[$_getTimestamp()] Response received: Status ${response.statusCode}',
          name: 'ProductsApiServices');
      log('[$_getTimestamp()] Raw API response: ${response.data}',
          name: 'ProductsApiServices');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> brandList = data['brands'] ?? [];
        log('[$_getTimestamp()] Brand list: $brandList',
            name: 'ProductsApiServices');
        return brandList.asMap().entries.map((entry) {
          final index = entry.key;
          final json = Map<String, dynamic>.from(entry.value);
          json['id'] = json['id'].toString();
          log('[$_getTimestamp()] Processing brand #$index: $json',
              name: 'ProductsApiServices');
          return BrandModel.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to fetch brands: ${response.statusMessage}');
      }
    } catch (e, stack) {
      log('[$_getTimestamp()] Error fetching brands: $e',
          name: 'ProductsApiServices', error: e, stackTrace: stack);
      throw Exception('Failed to fetch brands: $e');
    }
  }
}