import 'package:hand_car/features/Accessories/model/orders/order_model.dart';
import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'my_orders_controller.g.dart';

@riverpod
Future<List<OrderSummary>> myOrders( ref) async {
  final cartService = CartApiService();
  return cartService.getMyOrders();
}