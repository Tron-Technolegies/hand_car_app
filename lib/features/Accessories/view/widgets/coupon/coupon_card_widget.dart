import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/model/coupon/coupon_model.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponCardWidget extends HookConsumerWidget {
  final CouponModel coupon;

  const CouponCardWidget({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCopied = useState(false);

    return Container(
      width: 350,
      padding: EdgeInsets.all(context.space.space_100),
      margin: EdgeInsets.only(right: context.space.space_100),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discount Section
            Text(
              '${coupon.discountPercentage.toStringAsFixed(0)}% OFF',
              style: context.typography.h3.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'FOR WHOLE ORDER',
              style: context.typography.bodyMedium.copyWith(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: context.space.space_100),

            // Coupon Code Section
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Code: ${coupon.couponCode}',
                    style: context.typography.bodyMedium.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    isCopied.value = true;
                    // Implement copy to clipboard functionality
                    // Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Coupon code copied!')),
                    // );
                  },
                  child: Text(
                    isCopied.value ? 'Copied!' : 'Copy',
                    style: context.typography.bodyMedium.copyWith(
                      color: isCopied.value ? Colors.green : Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            // Apply Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Implement apply coupon logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.space.space_200,
                    vertical: context.space.space_50,
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),

            // Validity Dates
            SizedBox(height: context.space.space_100),
            Text(
              'Valid from ${coupon.startDate.toString().split(' ')[0]} '
              'to ${coupon.endDate.toString().split(' ')[0]}',
              style: context.typography.bodySmall.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}