// // import 'package:flutter/material.dart';
// // // ignore: depend_on_referenced_packages
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:hand_car/features/Accessories/services/product_search_service.dart';

// // class ProductSearchPage extends ConsumerWidget {
// //   const ProductSearchPage({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final productsAsync = ref.watch(productProvider);
// //     final searchQueryProvider =
// //         StateProvider<String>((ref) => ""); // For managing search query

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Consumer(
// //           builder: (context, watch, _) {
// //             final query = ref.watch(searchQueryProvider);
// //             return TextField(
// //               onChanged: (query) {
// //                 ref.read(searchQueryProvider.notifier).state = query;
// //               },
// //               decoration: const InputDecoration(
// //                 hintText: 'Search products...',
// //                 border: InputBorder.none,
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //       body: productsAsync.when(
// //         data: (products) {
// //           final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
// //           final filteredProducts = products
// //               .where(
// //                   (product) => product.name.toLowerCase().contains(searchQuery))
// //               .toList();

// //           if (filteredProducts.isEmpty) {
// //             return const Center(child: Text("No products found."));
// //           }

// //           return ListView.builder(
// //             itemCount: filteredProducts.length,
// //             itemBuilder: (context, index) {
// //               final product = filteredProducts[index];
// //               return ListTile(
// //                 leading: product.imageUrl != null
// //                     ? Image.network(
// //                         product.imageUrl!,
// //                         width: 50,
// //                         height: 50,
// //                         fit: BoxFit.cover,
// //                       )
// //                     : const Icon(Icons.image_not_supported),
// //                 title: Text(product.name),
// //                 subtitle: Text("Price: AED ${product.price}"),
// //                 trailing: Text("Brand: ${product.brand}"),
// //                 onTap: () {
// //                   // Handle product click
// //                 },
// //               );
// //             },
// //           );
// //         },
// //         error: (error, stackTrace) => Center(child: Text('Error: $error')),
// //         loading: () => const Center(child: CircularProgressIndicator()),
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class ProductSearchPage extends HookConsumerWidget {
//   const ProductSearchPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productsState = ref.watch(productsControllerProvider);
//     final searchController = useTextEditingController();
//     final debouncer = useState(Timer(Duration.zero, () {}));

//     void performSearch(String query) {
//       debouncer.value.cancel();
//       debouncer.value = Timer(const Duration(milliseconds: 500), () {
//         ref.read(productsControllerProvider.notifier).searchProducts(query);
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: searchController,
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Search products...',
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: const Icon(Icons.clear),
//               onPressed: () {
//                 searchController.clear();
//                 performSearch('');
//               },
//             ),
//           ),
//           onChanged: performSearch,
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: productsState.when(
//         data: (state) => state.when(
//           initial: () => const Center(child: Text('Search for products')),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           searching: () => const Center(child: CircularProgressIndicator()),
//           searchResults: (response) => response.accessories.isEmpty
//               ? const Center(child: Text('No products found'))
//               : GridView.builder(
//                   padding: const EdgeInsets.all(16),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.75,
//                     mainAxisSpacing: 16,
//                     crossAxisSpacing: 16,
//                   ),
//                   itemCount: response.accessories.length,
//                   itemBuilder: (context, index) {
//                     final product = response.accessories[index];
//                     return Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                             child: product.image != null
//                                 ? Image.network(
//                                     product.image!,
//                                     height: 120,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Container(
//                                     height: 120,
//                                     color: Colors.grey[200],
//                                     child: const Icon(Icons.image),
//                                   ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.name,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   product.brand,
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   '\$${product.price}',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//           loaded: (_) => const SizedBox(),
//           error: (message) => Center(child: Text('Error: $message')),
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }
