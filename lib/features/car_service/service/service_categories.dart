import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/service_category/service_category_model.dart';

class ServiceCategoriesService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    )
  );
 Future<List<ServiceCategoryModel>>getCategory()async{
  try {
    final response=await _dio.get('/view_service_categories_user');
    if(response.statusCode==200){
      final List<dynamic>categoryList=response.data['service_categories'];
      return categoryList.map((category) => ServiceCategoryModel.fromJson(category)).toList();
    }
    throw Exception('Failed to fetch categories');
  } catch (e) {
    throw Exception('Failed to fetch categories: $e');
  }
}
}