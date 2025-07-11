import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/model/products/promoted_brands/promoted_brands_model.dart';
import 'package:hand_car/features/Accessories/services/products_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promoted_brand_controller.g.dart';

@riverpod
class PromotedBrandController extends _$PromotedBrandController {
  @override
  Future<List<PromotedBrandProductModel>> build() async {
    return fetchBrands();
  }

  Future<List<PromotedBrandProductModel>> fetchBrands() async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      return await productsApiService.getPromotedBrands();
    } catch (e) {
      return [];
    }
  }
}