import 'package:hand_car/features/Accessories/model/products/promoted_products/promoted_products_model.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promoted_products_controller.g.dart';

@riverpod
class PromotedProductsController extends _$PromotedProductsController {
  @override
  Future<List<PromotedProductsModel>> build() async {
    return fetProducts();
  }

  Future<List<PromotedProductsModel>> fetProducts() async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      return await productsApiService.getPromotedProducts();
    } catch (e) {
      return [];
      
   
    }
  
  }
}
