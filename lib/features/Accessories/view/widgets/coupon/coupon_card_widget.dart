import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart'; // For parsing HTML

class CouponCardWidget extends HookConsumerWidget {
  final CouponModel coupon;
  final VoidCallback onApply;

  const CouponCardWidget({
    super.key,
    required this.coupon,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Function to extract list items from HTML
    List<String> extractListItems(String htmlString) {
      final document = parse(htmlString); // Parse the HTML
      return document
          .querySelectorAll('li') // Find all <li> elements
          .map((element) => element.text.trim()) // Extract text content
          .toList(); // Convert to list of strings
    }

    // Extract list items from coupon description
    final List<String> descriptionItems = extractListItems(coupon.description);

    final isCopied = useState(false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Discount Section
          Text(
            '${coupon.discountPercentage.toStringAsFixed(0)}% OFF',
            style: context.typography.h3.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            coupon.name,
            style: context.typography.bodyMedium.copyWith(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),

          // Coupon Code and Buttons Section
          Row(
            children: [
              // Coupon Code
              Expanded(
                child: Text(
                  'Code: ${coupon.couponCode}',
                  style: context.typography.bodyMedium.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Copy Button
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: coupon.couponCode),
                  );
                  isCopied.value = true;
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Coupon code "${coupon.couponCode}" copied!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    isCopied.value = false;
                  });
                },
                child: Icon(
                  Icons.copy,
                  size: 20,
                  color: isCopied.value ? Colors.green : Colors.black87,
                ),
              ),
              SizedBox(width: context.space.space_200),
              // Apply Button
              GestureDetector(
                onTap: onApply,
                child: Row(
                  children: [
                    Text(
                      'Apply',
                      style: context.typography.bodyMedium.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: context.space.space_50),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Description Section
          if (descriptionItems.isNotEmpty) ...[
            const SizedBox(height: 4),
            for (var item in descriptionItems)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.brightness_1,
                        size: 8, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: context.typography.body.copyWith(
                          color: Colors.black87,
                          height: 0.8, // Line height for readability
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          const SizedBox(height: 8),

          // Validity Section
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
    );
  }
}
