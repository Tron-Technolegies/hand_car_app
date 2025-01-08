import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/model/products/promoted_brands/promoted_brands_model.dart';
import 'package:hand_car/features/Accessories/model/products/promoted_products/promoted_products_model.dart';
import 'package:hand_car/features/Accessories/model/serach_products/search_response_model.dart';

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
      print('Raw API response: ${response.data}');
      
      final List<dynamic> productList = response.data['product'];
      print('Product list: $productList');

      return productList.map((dynamic item) {
        // Convert the dynamic Map to Map<String, dynamic>
        final Map<String, dynamic> json = Map<String, dynamic>.from(item as Map);
        
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
          print('Error parsing product: $e');
          print('Product data: $modifiedJson');
          rethrow;
        }
      }).toList();
      
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to fetch products: ${e.message}');
    } catch (e, stack) {
      print('Error fetching products: $e');
      print('Stack trace: $stack');
      throw Exception('Failed to fetch products: $e');
    }
  }
  /// Search products

  Future<SearchResponse> searchProducts(String query) async {
    try {
      final response = await _dio
          .get('/searchproducts/', queryParameters: {'search': query});
      return SearchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Search failed: ${e.message}');
    }
  }

  //Promoted Brands
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
      final response =
          await _dio.get('/view_promoted_products'); // Adjust endpoint as needed
      final List<dynamic> data = response.data['promoted_products'];
      log('Promoted products data: $data');
      return data.map((json) => PromotedProductsModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch promoted products: $e');
    }

  }

   Future<List<ProductsModel>> getFilteredProducts(Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.get(
        '/filter/products',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => ProductsModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch filtered products');
      }
    } catch (e) {
      throw Exception('Error fetching filtered products: $e');
    }
  }
}
