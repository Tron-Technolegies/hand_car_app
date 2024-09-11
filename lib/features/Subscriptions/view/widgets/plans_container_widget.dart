import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plan_discount_widget.dart';

class PlansContainer extends StatelessWidget {
  final String planName;
  final String price;
  final String planFeature1;
  final String planFeature2;
  final String? planFeature3;
  final String? planFeature4;

  const PlansContainer({
    super.key,
    required this.planName,
    required this.price,
    required this.planFeature1,
    required this.planFeature2,
    this.planFeature3,
    this.planFeature4,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: const [
                  Text(
                    'Multiple Cars Discount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PlanDiscountWidget(
                      number: '1', plan: "Car Plan", price: "Full Price"),
                  PlanDiscountWidget(
                      number: '2', plan: "Car Plan", price: "10%off/car"),
                  PlanDiscountWidget(
                      number: '3', plan: "Car+ Plan", price: "20%off/car"),
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
            const Center(
              child: Text(
                'Save 10% off on 6 months subscription',
                style: TextStyle(color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}