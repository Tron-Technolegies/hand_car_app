import 'package:flutter/material.dart';

import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/coupon/coupon_controller.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_card_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponCardListView extends ConsumerWidget {
  final void Function(CouponModel coupon) onCouponApply;

  const CouponCardListView({super.key, required this.onCouponApply});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final couponAsync = ref.watch(couponControllerProvider);

    return couponAsync.when(
      data: (coupons) {
        if (coupons.isEmpty) {
          return Center(
            child: Text(
              'No Coupons Available',
              style: context.typography.bodyMedium,
            ),
          );
        }

        return SizedBox(
          height: 210, // Define a fixed height for the card view
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 320, // Constrain each card to a fixed width
                child: CouponCardWidget(
                  coupon: coupons[index],
                  onApply: () => onCouponApply(coupons[index]),
                ),
              );
            },
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: context.colors.primary,
        ),
      ),
      error: (error, stack) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load coupons',
                style: context.typography.bodyMedium,
              ),
              Text(
                error.toString(),
                style: context.typography.bodySmall.copyWith(color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
