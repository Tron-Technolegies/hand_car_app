import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class CouponCardWidget extends HookWidget {
  const CouponCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isCopied = useState(false);

  return Container(
  width: 350,
  padding: EdgeInsets.all(context.space.space_100),
  margin: EdgeInsets.only(right: context.space.space_100),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey[300]!),
    borderRadius: BorderRadius.circular(8),
  ),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5% OFF',
          style: context.typography.h3,
        ),
        Text('FOR WHOLE ORDER', style: context.typography.bodyMedium),
        SizedBox(height: context.space.space_100),
        OverflowBar(
          children: [
            Text(
              'Code: NEWCUSTOMER_1234',
              style: context.typography.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                isCopied.value = true;
                // Add actual copy functionality here
              },
              child: Text(
                isCopied.value ? 'Copied!' : 'Copy',
                style: context.typography.bodyMedium
                    .copyWith(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Apply',
                  style: context.typography.bodyMedium
                      .copyWith(color: Colors.green)),
            ),
          ],
        ),
      ],
    ),
  ),
);
  }
}
