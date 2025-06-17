import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class MyOrdersPage extends StatelessWidget {
  static const String route = '/my-orders';
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.colors.primaryTxt,
          ),
        ),
        title: Text(
          'My Orders',
          style: context.typography.bodyLarge.copyWith(
            color: context.colors.primaryTxt,
          ),
        ),
      ),

    );
  }
}




class OrderItem extends StatelessWidget {
  final String orderId;
  final String items;
  final String coupon;
  final double price;
  final int quantity;
  

  const OrderItem({
    super.key,
    required this.orderId,
    required this.items,
    required this.coupon,
    required this.price,
    required this.quantity,
 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Miner image
        CircleAvatar(
          
        ),
        // Item details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items,
                style: context.typography.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.space.space_50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '($coupon)',
                    style: context.typography.body.copyWith(color: Colors.grey),
                  ),
                  Text(
                    'AED $price',
                    style: context.typography.body.copyWith(color: Colors.cyan),
                  ),
                ],
              ),
              SizedBox(height: context.space.space_50),
              Text(
                'Qnty : $quantity',
                style: context.typography.body.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}