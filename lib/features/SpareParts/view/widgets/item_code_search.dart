import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCodeSearch extends StatelessWidget {
  const ItemCodeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController itemCodeController = TextEditingController();

    Future<void> launchWhatsApp(String itemCode) async {
      final message = Uri.encodeComponent(
          "Hello, I'm looking to find spare parts for the item with code:$itemCode");
      final whatsappUrl = Uri.parse("https://wa.me/971503507618?text=$message");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        SnackbarUtil.showsnackbar(
            message: "Could not launch WhatsApp", showretry: true);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              colors: [Color(0xff0069E4), Color(0xff0069E4)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.space.space_200),
              Center(
                child: Column(children: [
                  Text(
                    "Find the best car spare parts ",
                    style: context.typography.bodyLarge.copyWith(
                      color: context.colors.white,
                    ),
                  ),
                  Text(
                    " from top brands by Item code.",
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
                      hintText: '  Enter Item Code ',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
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
                        launchWhatsApp(itemCodeNumber);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Please enter a valid Item Code number"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: context.space.space_200),
            ],
          ),
        ),
      ),
    );
  }
}
