import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/my_orders/my_orders_controller.dart';
import 'package:hand_car/features/Accessories/model/orders/order_model.dart';

class MyOrdersPage extends ConsumerWidget {
  static const String route = '/my-orders';
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(myOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios, color: context.colors.primaryTxt),
        ),
        title: Text(
          'My Orders',
          style: context.typography.bodyLarge.copyWith(
            color: context.colors.primaryTxt,
          ),
        ),
      ),
      body: ordersAsync.when(
        data: (orders) => _buildOrderList(context, orders),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, List<OrderSummary> orders) {
    if (orders.isEmpty) {
      return Center(child: Text('No orders found'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _OrderCard(order: orders[index]),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderSummary order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order #${order.orderId}', 
                  style: context.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold
                  )),
                _buildStatusBadge(context),
              ],
            ),
            SizedBox(height: 12),
            Text('Placed on ${_formatDate(order.createdAt)}'),
            SizedBox(height: 12),
            ...order.items.map((item) => _OrderItemRow(item: item)).toList(),
            Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: context.typography.body),
                Text('AED ${order.totalPrice.toStringAsFixed(2)}',
                  style: context.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold
                  )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color statusColor;
    switch (order.status.toLowerCase()) {
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'shipped':
        statusColor = Colors.blue;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        order.status,
        style: context.typography.body.copyWith(color: statusColor),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            // Placeholder for product image
            child: Icon(Icons.shopping_bag, color: Colors.grey[400]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, 
                  style: context.typography.body.copyWith(
                    fontWeight: FontWeight.w500
                  )),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('AED ${item.price.toStringAsFixed(2)}',
                      style: context.typography.body),
                    SizedBox(width: 16),
                    Text('Qty: ${item.quantity}',
                      style: context.typography.body.copyWith(
                        color: Colors.grey[600]
                      )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}