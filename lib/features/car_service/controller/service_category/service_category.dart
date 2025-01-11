import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_category.g.dart';

@riverpod
class ServiceCategoryFilter extends _$ServiceCategoryFilter {
  @override
  String build() {
    return "Painting"; // Default category
  }

  void setCategory(String category) {
    state = category;
  }
}