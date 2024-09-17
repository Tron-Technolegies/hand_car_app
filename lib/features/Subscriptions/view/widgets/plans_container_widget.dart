import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/duration_button_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plan_discount_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlansContainer extends HookConsumerWidget {
  final String planName;
  final String price;
  final String planFeature1;
  final String planFeature2;
  final String? planFeature3;
  final String? planFeature4;
  final Color color;
  final Color textColor1;
  final Color textColor2;
  final Color containerColor;

  const PlansContainer({
    super.key,
    required this.planName,
    required this.price,
    required this.planFeature1,
    required this.planFeature2,
    this.planFeature3,
    this.planFeature4,
    required this.color,
    required this.textColor1,
    required this.textColor2,
    required this.containerColor
  });

  @override
  Widget build(BuildContext context,ref) {
    final selectedIndex=useState(0);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.space.space_250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planName,
              style: context.typography.bodyLarge
                  .copyWith(color: context.colors.primaryTxt),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'AED $price ',
                style: context.typography.h2,
                children: [
                  TextSpan(
                    text: '/month',
                    style: context.typography.bodyMedium
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FeaturesCheckIconWidget(text: planFeature1),
            FeaturesCheckIconWidget(text: planFeature2),
            if (planFeature3 != null && planFeature3!.isNotEmpty)
              FeaturesCheckIconWidget(text: planFeature3!),
            if (planFeature4 != null && planFeature4!.isNotEmpty)
              FeaturesCheckIconWidget(text: planFeature4!),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(context.space.space_250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.background,
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Multiple Cars Discount',
                    style: context.typography.bodyLarge,
                  ),
                  SizedBox(height: context.space.space_150),
                  PlanDiscountWidget(
                      number: '1', plan: "Car Plan", price: "Full Price",color: color,),
                  PlanDiscountWidget(
                      number: '2', plan: "Car Plan", price: "10%off/car",color: color,),
                  PlanDiscountWidget(
                      number: '3', plan: "Car+ Plan", price: "20%off/car",color: color,),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: SizedBox(
                width: double.infinity,
                child: ButtonWidget(label: 'Subscribe', onTap: () {}),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: DurationButtons(selectedIndex: selectedIndex.value, onSelectPlan: (index) {
                selectedIndex.value = index;
              },
              containerColor: containerColor,
              textColor1: textColor1,
              textColor2: textColor2,
              ),
            ),
             SizedBox(height: context.space.space_200,)
            ,
             Center(
              child:RichText(text: TextSpan(
                text: 'Save 10% off ',
                style: context.typography.bodyMedium
                    .copyWith(color: context.colors.green),
                children: [
                  TextSpan(
                    text: ' on 6 months subscription',
                    style: context.typography.bodyMedium
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                ],
              ))
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}