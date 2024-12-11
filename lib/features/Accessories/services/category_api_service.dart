import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/products/category_model.dart';

class CategoryApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('/view_category');
    

      // Safely extract the categories key
      final categoryList = response.data['categories'] as List<dynamic>?;

      if (categoryList == null || categoryList.isEmpty) {
        throw Exception('Categories list is null or empty');
      }

      

      // Map each category to a Category model
      return categoryList.map((item) => Category.fromJson(item)).toList();
    } on DioException catch (e) {
      
      throw Exception('Failed to fetch categories: ${e.message}');
    } catch (e) {
     
      throw Exception('An unexpected error occurred.');
    }
  }
}
