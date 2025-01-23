import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/service/log_intreaction/service_interaction_service.dart';
import 'package:hand_car/features/car_service/view/widgets/review/review_list_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/review/service_review_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/services_list_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsPage extends ConsumerWidget {
  static const route = '/serviceDetailsPage';
  final ServiceModel service;
  final ServiceRatingModel? rating;

  const ServiceDetailsPage({
    super.key,
    required this.service,
    this.rating,
  });

  String cleanImageUrl(String originalUrl) {
    String cleanedUrl =
        originalUrl.startsWith('/') ? originalUrl.substring(1) : originalUrl;
    return Uri.decodeComponent(cleanedUrl);
  }

  Future<void> makePhoneCall(BuildContext context, WidgetRef ref, ServiceModel service) async {
 final Uri launchUri = Uri(scheme: 'tel', path: service.phoneNumber);

 try {
   if (await canLaunchUrl(launchUri)) {
     await ref.read(serviceInteractionApiProvider).logInteraction(
       service.id.toString(),
       'CALL'
     );
     await launchUrl(launchUri);
   } else {
     throw Exception('Could not launch phone call');
   }
 } catch (e) {
   log('Error in makePhoneCall: $e');
   SnackbarUtil.showsnackbar(
     message: "Could not make phone call",
     showretry: true,
   );
 }
}
 
Future<void> launchWhatsApp(BuildContext context, WidgetRef ref, ServiceModel service) async {
  final whatsappUrl = Uri.parse("https://wa.me/${service.phoneNumber}");
  
  try {
    if (await canLaunchUrl(whatsappUrl)) {
      await ref.read(serviceInteractionApiProvider).logInteraction(
        service.id.toString(), 
        'WHATSAPP'
      );
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch WhatsApp');
    }
  } catch (e) {
    log('Error in launchWhatsApp: $e');
    SnackbarUtil.showsnackbar(
      message: "Could not launch WhatsApp",
      showretry: true,
    );
  }
}

// Optional: Add feedback for successful interactions
  void _showInteractionSuccess(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully initiated $action'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final CarouselSliderControllerImpl carouselController =
        CarouselSliderControllerImpl();
    final ValueNotifier<int> currentImageIndex = ValueNotifier(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section
            if (service.images.isNotEmpty) ...[
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        height: 250,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: service.images.length > 1,
                        reverse: false,
                        autoPlay: service.images.length > 1,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          currentImageIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      items: service.images.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              cleanImageUrl(imageUrl),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.error),
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  if (service.images.length > 1) ...[
                    Positioned(
                      left: 10,
                      child: IconButton(
                        onPressed: () => carouselController.previousPage(),
                        icon: const CircleAvatar(
                          backgroundColor: Colors.black45,
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        onPressed: () => carouselController.nextPage(),
                        icon: const CircleAvatar(
                          backgroundColor: Colors.black45,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: ValueListenableBuilder<int>(
                        valueListenable: currentImageIndex,
                        builder: (context, index, _) {
                          return AnimatedSmoothIndicator(
                            activeIndex: index,
                            count: service.images.length,
                            effect: WormEffect(
                              dotColor: Colors.white60,
                              activeDotColor: context.colors.primary,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: context.space.space_200),
            ],

            // Title and Rating
            // Title and Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    service.vendorName,
                    style: context.typography.h2.copyWith(
                      color: context.colors.primaryTxt,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final ratingAsync =
                        ref.watch(serviceRatingControllerProvider);

                    return ratingAsync.when(
                      data: (ratingList) {
                        final totalReviews = ratingList.ratings.length;
                        final averageRating = ratingList.ratings.isEmpty
                            ? 0.0
                            : ratingList.ratings.fold(
                                    0, (sum, rating) => sum + rating.rating) /
                                totalReviews;

                        return Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              averageRating.toStringAsFixed(1),
                              style: context.typography.bodyLarge,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '($totalReviews)',
                              style: context.typography.bodyMedium.copyWith(
                                color:
                                    context.colors.primaryTxt.withValues(alpha:0.6),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => Row(
                        children: [
                          const Icon(Icons.star, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '0.0',
                            style: context.typography.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: context.space.space_300),

            // Contact Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Column(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () =>
                              launchWhatsApp(context, ref, service),
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Chat US",
                        style: context.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => makePhoneCall(context, ref, service),
                        icon: const Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Call US",
                      style: context.typography.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: context.space.space_200),

            // Address Section
            Text(
              "Address",
              style: context.typography.bodyLargeSemiBold.copyWith(
                color: context.colors.primary,
              ),
            ),
            SizedBox(height: context.space.space_100),
            Text(
              service.address,
              style: context.typography.bodyMedium,
            ),

            SizedBox(height: context.space.space_200),

            // Services Section
            Text(
              "Services",
              style: context.typography.bodyLargeSemiBold.copyWith(
                color: context.colors.primary,
              ),
            ),
            ServiceListWidget(
              services: service.serviceDetails.split(','),
            ),

            // Price
            // Text(
            //   'AED ${service.rate}/hr',
            //   style: context.typography.h2,
            // ),

            SizedBox(height: context.space.space_200),

            SizedBox(height: context.space.space_200),

            // Reviews Section
            SizedBox(
                height: context.space.space_500 * 9,
                child: ServiceReviewWidget(
                  serviceId: service.id.toString(),
                  serviceName: service.vendorName,
                )),
            ReviewsList(
              vendorName:
                  service.vendorName, // Change from service.id.toString()
              serviceId: service.id,
            ),
          ],
        ),
      ),
    );
  }
}
