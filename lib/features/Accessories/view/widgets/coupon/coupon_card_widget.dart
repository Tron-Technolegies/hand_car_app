// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // For Clipboard
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Accessories/controller/model/coupon/coupon_model.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class CouponCardWidget extends HookConsumerWidget {
//   final CouponModel coupon;

//   const CouponCardWidget({
//     super.key,
//     required this.coupon,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isCopied = useState(false);

//     return Container(
//       width: 350,
//       padding: EdgeInsets.all(context.space.space_100),
//       margin: EdgeInsets.only(right: context.space.space_100),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 2,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Discount Section
//             Text(
//               '${coupon.discountPercentage.toStringAsFixed(0)}% OFF',
//               style: context.typography.h3.copyWith(
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'FOR WHOLE ORDER',
//               style: context.typography.bodyMedium.copyWith(
//                 color: Colors.black54,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             SizedBox(height: context.space.space_100),

//             // Coupon Code Section
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Code: ${coupon.couponCode}',
//                     style: context.typography.bodyMedium.copyWith(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     // Copy coupon code to clipboard
//                     await Clipboard.setData(
//                       ClipboardData(text: coupon.couponCode),
//                     );

//                     // Update isCopied state
//                     isCopied.value = true;

//                     // Show feedback to user
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content:
//                             Text('Coupon code "${coupon.couponCode}" copied!'),
//                         duration: const Duration(seconds: 2),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );

//                     // Reset the `isCopied` state after a delay
//                     Future.delayed(const Duration(seconds: 2), () {
//                       isCopied.value = false;
//                     });
//                   },
//                   child: Text(
//                     isCopied.value ? 'Copied!' : 'Copy',
//                     style: context.typography.bodyMedium.copyWith(
//                       color: isCopied.value ? Colors.green : Colors.black54,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Apply Button
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Implement apply coupon logic
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: context.space.space_200,
//                     vertical: context.space.space_50,
//                   ),
//                 ),
//                 child: const Text('Apply'),
//               ),
//             ),

//             // Validity Dates
//             SizedBox(height: context.space.space_100),
//             Text(
//               'Valid from ${coupon.startDate.toString().split(' ')[0]} '
//               'to ${coupon.endDate.toString().split(' ')[0]}',
//               style: context.typography.bodySmall.copyWith(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/model/coupon/coupon_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final isCopied = useState(false);

    return Container(
      width: 300, // Explicitly constrain width
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView( // Wrap content in a scrollable widget
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevent expanding unnecessarily
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
              'FOR WHOLE ORDER',
              style: context.typography.bodyMedium.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

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
                // Copy and Apply Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: coupon.couponCode),
                        );
                        isCopied.value = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Coupon code "${coupon.couponCode}" copied!'),
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
                    const SizedBox(width: 16),
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
                          const SizedBox(width: 4),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}