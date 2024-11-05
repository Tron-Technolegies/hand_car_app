import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_card_widget.dart';

class CouponCardListView extends HookWidget {
  const CouponCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
      child: SizedBox(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
          itemCount: 3,
          itemBuilder: (context, index) => const CouponCardWidget(),
        ),
      ),
    );
  }
}
