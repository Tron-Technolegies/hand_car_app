import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/coupon/coupon_controller.dart';

import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_card_widget.dart';

class CouponCardListView extends ConsumerWidget {
  const CouponCardListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final couponAsync = ref.watch(couponControllerProvider);

    return couponAsync.when(
      data: (coupons) {
        // Debug print to verify coupons
        debugPrint('Coupons received: ${coupons.length}');
        
        if (coupons.isEmpty) {
          return Center(
            child: Text(
              'No Coupons Available',
              style: context.typography.bodyMedium,
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
          child: SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
              itemCount: coupons.length,
              itemBuilder: (context, index) {
                // Debug print for each coupon
                debugPrint('Rendering Coupon: ${coupons[index].name}');
                return CouponCardWidget(
                  coupon: coupons[index],
                );
              },
            ),
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: context.colors.primary,
        ),
      ),
      error: (error, stack) {
        // More detailed error logging
        debugPrint('Coupon Fetch Error: $error');
        debugPrint('Stack Trace: $stack');
        
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