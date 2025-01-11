
import 'package:hand_car/features/car_service/model/service_category/service_category_model.dart';
import 'package:hand_car/features/car_service/service/service_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_filter.g.dart';




@riverpod

@riverpod
class ServiceCategoryController extends _$ServiceCategoryController {
  late final ServiceCategoriesService _service;

  @override
  Future<List<ServiceCategoryModel>> build() async {
    _service = ServiceCategoriesService();
    return _fetchCategories();
  }

  Future<List<ServiceCategoryModel>> _fetchCategories() async {
    try {
      final categories = await _service.getCategory();
      return categories;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<void> refreshCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _service.getCategory();
      state = AsyncValue.data(categories);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}