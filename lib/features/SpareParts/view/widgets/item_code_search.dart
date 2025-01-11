import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCodeSearch extends StatelessWidget {
  const ItemCodeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller to get the text from the TextField
    final TextEditingController itemCodeController = TextEditingController();

    // Function to launch WhatsApp

    Future<void> launchWhatsApp(
      String itemCode,
    ) async {
      final message = Uri.encodeComponent(
          "Hello, I would like to search for spare parts for chassis number: $itemCode");

      final whatsappUrl = Uri.parse("https://wa.me/9895499872?text=$message");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback if canLaunchUrl fails
        SnackbarUtil.showsnackbar(
            message: "Could not launch WhatsApp", showretry: true);
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
         Color(0xff0069E4),
         Color(0xff0069E4),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: context.space.space_200),
          Center(
            child: Column(children: [
              Text(
                "   Enter your chassis number to discover",
                style: context.typography.bodyLarge.copyWith(
                  color: context.colors.white,
                ),
              ),
              Text(
                "  tailored spare parts for your car.",
                style: context.typography.bodyLarge.copyWith(
                  color: context.colors.white,
                ),
              ),
            ]),
          ),
          SizedBox(height: context.space.space_200),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_200,
                vertical: context.space.space_100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.colors.white,
              ),
              child: TextField(
                controller: itemCodeController,
                decoration: const InputDecoration(
                  hintText: '  Enter Chassis Number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_200,
                vertical: context.space.space_100),
            child: SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                  label: "Search",
                  onTap: () {
                    String itemCodeNumber = itemCodeController.text;

                    if (itemCodeNumber.isNotEmpty) {
                      // Replace with actual phone number
                      launchWhatsApp(
                        itemCodeNumber,
                      );
                    } else {
                      // Show an error if the chassis number is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please enter a valid chassis number")),
                      );
                    }
                  }),
            ),
          ),
          SizedBox(height: context.space.space_100),
          SizedBox(height: context.space.space_100),
        ],
      ),
    );
  }
}
