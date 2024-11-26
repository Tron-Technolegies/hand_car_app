import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final productProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final dio = Dio();
  final response = await dio.get('$baseUrl/searchproducts/');
  final products = response.data['accessories'] as List<dynamic>;
  return products.map((product) => Product.fromJson(product)).toList();
});