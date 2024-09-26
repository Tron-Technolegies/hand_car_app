import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SpareBrandsContainerWidget extends StatelessWidget {
  final String brandImage;
  const SpareBrandsContainerWidget({super.key, required this.brandImage});

  @override
  Widget build(BuildContext context) {
     Future<void> launchWhatsApp(
      
    ) async {
     

      final whatsappUrl = Uri.parse("https://wa.me/9895499872");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback if canLaunchUrl fails
        SnackbarUtil.showsnackbar(
            message: "Could not launch WhatsApp", showretry: true);
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
                child: ButtonWidget(label: "Enquire now", onTap: () {
                  launchWhatsApp();
                }

           )),
          )
        ]),
      ),
    );
  }
}
