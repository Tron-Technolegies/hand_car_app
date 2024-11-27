import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/controller/model/serach_products/search_response_model.dart';

class ProductsApiServices{
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      
    )
  );
  Future<List<ProductsModel>> getProducts() async {
    try {
      final response = await _dio.get('/view_product');
      final List<dynamic> productList = response.data['product'];
      return productList.map((json) => ProductsModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }
  Future<SearchResponse> searchProducts(String query) async {
    try {
      final response = await _dio.get('/product-search', 
        queryParameters: {'search': query}
      );
      return SearchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Search failed: ${e.message}');
    }
  }
}
  
