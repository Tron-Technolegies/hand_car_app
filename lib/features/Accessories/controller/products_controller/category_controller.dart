import 'package:hand_car/features/Accessories/model/products/category_model.dart';
import 'package:hand_car/features/Accessories/services/category_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryController extends _$CategoryController {
  @override
  Future<List<Category>> build() async {
    return await _fetchCategories(); // Directly return the fetched categories
  }

  // Fetch categories from the API
  Future<List<Category>> _fetchCategories() async {
    try {
      final data = await CategoryApiService().getCategories();

      return data;
    } catch (error) {
      throw Exception('Failed to fetch categories');
    }
  }

  // Refresh categories and update the state
  Future<void> refreshCategories() async {
    state = const AsyncValue.loading(); // Set the loading state
    try {
      final categories = await _fetchCategories();
      state = AsyncValue.data(categories); // Update with new data
    } catch (error, stackTrace) {
      
      state = AsyncValue.error(error, stackTrace); // Set the error state
    }
  }
}
