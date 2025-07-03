import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PlansContainer extends HookConsumerWidget {
  final String planName;
  final String price;
  final String description;
  final String duration;
  final Color color;
  final Color textColor1;
  final Color textColor2;
  final Color containerColor;
  final Widget? child;

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
    this.child,
  });

  String createWhatsAppUrl(String plan, String price, String duration) {
    final message = Uri.encodeComponent(
        "I would like to subscribe to the $plan plan for $duration months at a price of AED $price.");
    return "https://wa.me/917025791186?text=$message";
  }

  List<String> parseFeatures(String description) {
    return description
        .split('\n')
        .map((feature) => feature.trim())
        .where((feature) => feature.isNotEmpty)
        .toList();
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
            if (duration == '12') ...[
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Save 10% off ',
                    style: context.typography.bodyMedium
                        .copyWith(color: context.colors.green),
                    children: [
                      TextSpan(
                        text: ' on 12 months subscription',
                        style: context.typography.bodyMedium
                            .copyWith(color: context.colors.primaryTxt),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.space.space_250),
            ],
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
                  // TextSpan(
                  //   text: '/$duration months',
                  //   style: context.typography.bodyMedium
                  //       .copyWith(color: context.colors.primaryTxt),
                  // ),
                ],
              ),
            ),
            SizedBox(height: context.space.space_250),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                final cleanFeature =
                    feature.startsWith('• ') ? feature.substring(2) : feature;

                return Padding(
                  padding: EdgeInsets.only(bottom: context.space.space_150),
                  child: FeaturesCheckIconWidget(text: cleanFeature),
                );
              },
            ),
            SizedBox(height: context.space.space_250),
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                label: 'Subscribe',
                onTap: () {
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
