import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plan_discount_widget.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PlansContainer extends HookConsumerWidget {
  final String planName;
  final String price;
  final String description; // Updated: single description field
  final String duration;
  final Color color;
  final Color textColor1;
  final Color textColor2;
  final Color containerColor;
  final Widget? child;
  final int selectedDuration;

  const PlansContainer({
    super.key,
    required this.planName,
    required this.price,
    required this.description,
    required this.duration,
    required this.color,
    required this.textColor1,
    required this.textColor2,
    required this.containerColor,
    required this.selectedDuration,
    this.child,
  });

  // Launch WhatsApp to Subscribe
  String createWhatsAppUrl(String plan, String price, int duration) {
    final message = Uri.encodeComponent(
        "I would like to subscribe to the $plan plan for $duration months at a price of AED $price.");
    return "https://wa.me/917025791186?text=$message";
  }

  // Split description into features
  List<String> parseFeatures(String description) {
    return description.split(',').map((feature) => feature.trim()).toList();
  }

  @override
  Widget build(BuildContext context, ref) {
    final features = parseFeatures(description);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  planName,
                  style: context.typography.bodyLarge
                      .copyWith(color: context.colors.primaryTxt),
                ),
                child ?? const SizedBox(),
              ],
            ),
            SizedBox(height: context.space.space_150),
            RichText(
              text: TextSpan(
                text: 'AED $price ',
                style: context.typography.h2,
                children: [
                  TextSpan(
                    text: '/$duration months',
                    style: context.typography.bodyMedium
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.space.space_250),
            // Display parsed features
            ...features.map((feature) => FeaturesCheckIconWidget(text: feature)),
            SizedBox(height: context.space.space_250),
            Container(
              padding: EdgeInsets.all(context.space.space_250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.background,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Multiple Cars Discount',
                    style: context.typography.bodyLarge,
                  ),
                  SizedBox(height: context.space.space_150),
                  // Plan Discount Widgets
                  PlanDiscountWidget(
                    number: '1',
                    plan: "Car Plan",
                    price: "Full Price",
                    color: color,
                  ),
                  PlanDiscountWidget(
                    number: '2',
                    plan: "Car Plan",
                    price: "10% off/car",
                    color: color,
                  ),
                  PlanDiscountWidget(
                    number: '3',
                    plan: "Car+ Plan",
                    price: "20% off/car",
                    color: color,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Save 10% off on 6 months subscription
            Center(
              child: RichText(
                text: TextSpan(
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
                ),
              ),
            ),
            SizedBox(height: context.space.space_250),
            // Subscribe Button
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                label: 'Subscribe',
                onTap: () {
                  final duration = selectedDuration == 0 ? 6 : 12;
                  final url = createWhatsAppUrl(planName, price, duration);
                  launchUrl(Uri.parse(url));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}