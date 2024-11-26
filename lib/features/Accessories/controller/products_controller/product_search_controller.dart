// import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';
// import 'package:hand_car/features/Accessories/services/product_search_service.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'product_search_controller.g.dart';

// @riverpod
// class ProductSearchController extends _$ProductSearchController {
//   final ProductSearchService _service = ProductSearchService();

//   /// Initializes the state with an empty response
//   Future<ProductSearchResponse> build() async {
//     return ProductSearchResponse(
//       accessories: [],
//       query: null,
//     );
//   }

//   /// Fetches products based on the query
//   Future<void> searchProducts(String query) async {
//     state = const AsyncValue.loading();
//     try {
//       final response = await _service.searchProducts(query);
//       state = AsyncValue.data(response);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }
// }
