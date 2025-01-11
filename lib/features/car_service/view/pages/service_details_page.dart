import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/car_service/view/widgets/services_list_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

//Service Details Page
class ServiceDetailsPage extends StatelessWidget {
  static const route = '/serviceDetailsPage';
  // List of services
  final List<String> services = [
    'Air and cabin filter replacement',
    'Battery',
    'Brakes',
    'Air conditioning',
    'Electrical',
    'Vehicle engine diagnostic',
    'Oil change',
    'Steering and suspension repair',
    'Transmission',
    'A/C installation and repair',
    'Vehicle A/C recharge',
    'Vehicle A/C replacement',
    'Vehicle battery maintenance',
    'Vehicle battery replacement',
    'Vehicle brake inspection',
  ];
  final String? image;
  final String title;
  final String title2;
  final String rating;
  final String price;

  ServiceDetailsPage({
    super.key,
    required this.image,
    required this.title,
    required this.title2,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Function to make phone call
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw Exception('Could not launch $phoneNumber');
      }
    }

    // Function to launch WhatsApp
    Future<void> launchWhatsApp() async {
      final whatsappUrl = Uri.parse("https://wa.me/9895499872");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback if canLaunchUrl fails
        SnackbarUtil.showsnackbar(
            message: "Could not launch WhatsApp", showretry: true);
      }
    }

// Function to send email
    // void sendEmail() async {
    //   // Define the Gmail-specific URI
    //   final Uri gmailUri = Uri(
    //     scheme: 'googlegmail',
    //     path: '/co',
    //     queryParameters: {
    //       'to': 'risanpt5@gmailcom',
    //       'subject': 'Inquiry from App',
    //       'body': 'Hello, I would like to inquire about...',
    //     },
    //   );

    //   // Fallback to mailto: if Gmail is not available
    //   final Uri mailtoUri = Uri(
    //     scheme: 'mailto',
    //     path: 'risanpt5@gmailcom', // Replace with the recipient's email
    //     queryParameters: {
    //       'subject': 'Inquiry from App',
    //       'body': 'Hello,I would like to inquire about...',
    //     },
    //   );

    //   // Attempt to launch Gmail
    //   if (await canLaunchUrl(gmailUri)) {
    //     await launchUrl(gmailUri);
    //   } else if (await canLaunchUrl(mailtoUri)) {
    //     // Fallback to mailto: if Gmail is not available
    //     await launchUrl(mailtoUri);
    //   } else {
    //     throw 'Could not launch email client';
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Service Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: image != null
                  ? Image.asset(
                      image!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(
                      fallbackHeight: 200,
                      fallbackWidth: double.infinity,
                    ),
            ),
            SizedBox(height: context.space.space_200),

            // Other details like title, rating, price, etc.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.typography.h2
                      .copyWith(color: context.colors.primaryTxt),
                ),
                Row(children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(rating, style: context.typography.bodyLarge),
                ])
              ],
            ),
            SizedBox(height: context.space.space_300),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: context.space.space_500,
              children: [
                Column(
                  spacing: context.space.space_100,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: 0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {
                            launchWhatsApp();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: "Chat US ",
                          style: context.typography.bodyMedium,
                        ),
                      ],
                    ))
                  ],
                ),
                Column(
                  spacing: context.space.space_100,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: 0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {
                            makePhoneCall('+971 55 249 9872');
                          },
                          icon: const Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.black,
                          )),
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: "Call US",
                          style: context.typography.bodyMedium,
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            ),

            SizedBox(height: context.space.space_200),

            Text(
              "Address",
              style: context.typography.bodyLargeSemiBold
                  .copyWith(color: context.colors.primary),
            ),
            SizedBox(height: context.space.space_100),
            Text(
              "M-33, MUSSAFAH , PLOT NO 26, STORE NO 2 POST BOX NO 37511 TEL: 025544140 ABUDHABI google coordinates: 24°21'23.5°N 54°30'32.2°E - Abu Dhabi - United Arab Emirates",
              style: context.typography.bodyMedium,
            ),
            SizedBox(height: context.space.space_100),
            Text(
              "Services",
              style: context.typography.bodyLargeSemiBold
                  .copyWith(color: context.colors.primary),
            ),
            ServiceListWidget(services: services),
            Text('AED $price/hr', style: context.typography.h2),
            SizedBox(height: context.space.space_200),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colors.green100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.colors.green,
                  )),
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.green,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(context.space.space_100),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: context.space.space_100 * 3,
                    ),
                  ),
                  SizedBox(width: context.space.space_100),
                  Text(
                    '20% discount coupon applied',
                    style: context.typography.bodyLargeSemiBold
                        .copyWith(color: context.colors.green),
                  ),
                ]),
              ),
            ),
            SizedBox(height: context.space.space_200),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.chat,
        backgroundColor: context.colors.secondaryTxt,
        children: [
          SpeedDialChild(
            child: Image.asset(Assets.icons.phone.path),
            label: 'Call US',
            onTap: () {
              makePhoneCall('9895499872');
            },
          ),
          SpeedDialChild(
            child: Image.asset(Assets.icons.whatsapp.path),
            label: 'Whatsapp US',
            onTap: () {
              launchWhatsApp();
            },
          ),
          // SpeedDialChild(
          //   child: Image.asset(Assets.icons.email.path),
          //   label: 'Email US',
          //   onTap: () async {
          //     showDialog(
          //       context: context,
          //       barrierDismissible: false,
          //       builder: (BuildContext context) {
          //         return const Center(child: CircularProgressIndicator());
          //       },
          //     );

          //     sendEmail();

          //     // Hide loading indicator
          //     Navigator.of(context).pop();
          //   },
          // ),
        ],
      ),
    );
  }
}
