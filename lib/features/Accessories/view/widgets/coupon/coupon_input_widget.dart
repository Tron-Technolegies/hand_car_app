import 'package:flutter/material.dart';
// For Clipboard
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponInputSection extends HookConsumerWidget {
  final TextEditingController controller;
  final void Function(String code) onApply;

  const CouponInputSection({
    super.key,
    required this.controller,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return Padding(
      padding: EdgeInsets.all(context.space.space_200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do you have any Coupon code?',
            style: context.typography.bodyLarge,
          ),
          SizedBox(height: context.space.space_100),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter code here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: context.space.space_200),
              ButtonWidget(
                label: "Apply",
                onTap: () => onApply(controller.text.trim()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
