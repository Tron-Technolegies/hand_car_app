// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hand_car/features/Accessories/services/product_search_service.dart';

// class ProductSearchPage extends ConsumerWidget {
//   const ProductSearchPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productsAsync = ref.watch(productProvider);
//     final searchQueryProvider =
//         StateProvider<String>((ref) => ""); // For managing search query

//     return Scaffold(
//       appBar: AppBar(
//         title: Consumer(
//           builder: (context, watch, _) {
//             final query = ref.watch(searchQueryProvider);
//             return TextField(
//               onChanged: (query) {
//                 ref.read(searchQueryProvider.notifier).state = query;
//               },
//               decoration: const InputDecoration(
//                 hintText: 'Search products...',
//                 border: InputBorder.none,
//               ),
//             );
//           },
//         ),
//       ),
//       body: productsAsync.when(
//         data: (products) {
//           final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
//           final filteredProducts = products
//               .where(
//                   (product) => product.name.toLowerCase().contains(searchQuery))
//               .toList();

//           if (filteredProducts.isEmpty) {
//             return const Center(child: Text("No products found."));
//           }

//           return ListView.builder(
//             itemCount: filteredProducts.length,
//             itemBuilder: (context, index) {
//               final product = filteredProducts[index];
//               return ListTile(
//                 leading: product.imageUrl != null
//                     ? Image.network(
//                         product.imageUrl!,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       )
//                     : const Icon(Icons.image_not_supported),
//                 title: Text(product.name),
//                 subtitle: Text("Price: AED ${product.price}"),
//                 trailing: Text("Brand: ${product.brand}"),
//                 onTap: () {
//                   // Handle product click
//                 },
//               );
//             },
//           );
//         },
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//         loading: () => const Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }
