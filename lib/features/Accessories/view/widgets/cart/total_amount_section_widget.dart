import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class TotalAmountSectionWidget extends HookWidget {
  final double total;
  final double delivery;
  final double grandTotal;

  const TotalAmountSectionWidget({
    super.key,
    required this.total,
    required this.delivery,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: context.typography.bodyMedium
                    .copyWith(color: const Color(0xff979797)),
              ),
              Text(
                'AED ${total.toStringAsFixed(2)}',
                style: context.typography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery',
                style: context.typography.bodyMedium
                    .copyWith(color: const Color(0xff979797)),
              ),
              Text(
                'AED ${delivery.toStringAsFixed(2)}',
                style: context.typography.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand total',
                  style: context.typography.bodyMedium
                      .copyWith(color: const Color(0xff979797))),
              Text(
                'AED ${grandTotal.toStringAsFixed(2)}',
                style: context.typography.bodyLarge.copyWith(
                  color: context.colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
