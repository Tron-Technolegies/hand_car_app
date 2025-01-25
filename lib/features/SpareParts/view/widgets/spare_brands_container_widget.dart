import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SpareBrandsContainerWidget extends StatelessWidget {
  final String brandImage;
  final String brandName;

  const SpareBrandsContainerWidget({
    super.key, 
    required this.brandImage,
    required this.brandName,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> launchWhatsApp() async {
      // Create a URL-encoded message that includes the brand name
      final message = Uri.encodeComponent(
     "Hello,I’m looking for spare parts for $brandName. Could you please provide more details?"
      );
      final whatsappUrl = Uri.parse("https://wa.me/971503507618?text=$message");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        SnackbarUtil.showsnackbar(
          message: "Could not launch WhatsApp",
          showretry: true
        );
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.white,
          border: Border.all(color: context.colors.background),
        ),
        padding: EdgeInsets.all(context.space.space_100),
        child: Column(children: [
          Image.asset(
            brandImage,
            height: 180,
            width: 180,
          ),
          SizedBox(height: context.space.space_100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
            child: SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                    label: "Enquire now",
                    onTap: () {
                      launchWhatsApp();
                    })),
          )
        ]),
      ),
    );
  }
}
