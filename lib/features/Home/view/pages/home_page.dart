import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/bottom_nav_controller.dart';
import 'package:hand_car/features/Home/view/widgets/accessories_ads_home_page_widget.dart';
import 'package:hand_car/features/Home/view/widgets/brand_wised_card_widget.dart';
import 'package:hand_car/features/Home/view/widgets/carousel_slider_widget.dart';
import 'package:hand_car/features/Home/view/widgets/container_for_home_page.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/Home/view/widgets/home_page_services_widget.dart';
import 'package:hand_car/features/Home/view/widgets/spare_brands_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

class HomePage extends ConsumerWidget {
  static const String route = '/home_page';
  const HomePage({super.key});

  @override

  /// The Home Page of the app.
  ///
  /// Contains a carousel with top brands, a section for spare parts, and a section for services.
  /// The user can navigate to the shopping cart, the drawer, and the different sections of the app.
  ///
  Widget build(BuildContext context, ref) {
    return Scaffold(
      key: scaffoldKey1,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(context.space.space_100),
          child: SvgPicture.asset(Assets.icons.handCarIcon),
        ),
        actions: [
          IconButton(
              onPressed: () {
                scaffoldKey1.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu)),
        ],
      ),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: context.space.space_200,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_200,
                vertical: context.space.space_100),
            child: Lottie.asset(
              Assets.animations.carRolling,
              height: 200,
              width: 550,
            ),
          ),
          ContainerForHomePage(
            text1: "Explore Best car Accessories  ",
            text2: "From Top Brands",
            text3: "View Products",
            image: "assets/images/accessories.png",
            onTap: () {
              ref.read(navigationProvider.notifier).changeSelectedItemIndex(1);
            },
          ),
          SizedBox(
            height: context.space.space_100,
          ),
          ContainerForHomePage(
              text1: 'Find best and cost effective',
              text2: 'Find Service',
              text3: "Find Service",
              image: 'assets/images/car.png',
              onTap: () {
                ref
                    .read(navigationProvider.notifier)
                    .changeSelectedItemIndex(3);
              }),
          SizedBox(
            height: context.space.space_100,
          ),
          ContainerForHomePage(
            text1: 'Find best in quality car spare',
            text2: 'Parts',
            text3: "Enquire Now",
            image: 'assets/images/spare_parts.png',
            onTap: () {
              ref.read(navigationProvider.notifier).changeSelectedItemIndex(0);
            },
          ),
          SizedBox(
            height: context.space.space_100,
          ),
          const CarouselSliderWidget(),
          SizedBox(
            height: context.space.space_300,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Today's Deals ",
                style: context.typography.h3
                    .copyWith(color: context.colors.primaryTxt)),
            TextSpan(
              text: "Up to 60% off",
              style:
                  context.typography.h3.copyWith(color: context.colors.primary),
            )
          ])),
          SizedBox(
            height: context.space.space_200,
          ),
          const AccessoriesAdsHomePageWidget(),
          SizedBox(
            height: context.space.space_200,
          ),
          Text(
            "Find Accessories by Brands",
            style: context.typography.h3,
          ),
          SizedBox(
            height: context.space.space_200,
          ),
          const BrandWisedCardWidget(),
          SizedBox(
            height: context.space.space_200,
          ),
          Text(
            "Handcar Car Services",
            style: context.typography.h3,
          ),
          SizedBox(
            height: context.space.space_100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_200,
                vertical: context.space.space_100),
            child: Text(
              "We Deliver Comprehensive Car Solutions! ",
              style: context.typography.body,
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            "Explore Our Range of Services",
            textAlign: TextAlign.center,
          ),
          Center(
              child: Image.asset(
            Assets.images.person.path,
            height: 250,
            width: 250,
          )),
          SizedBox(
            height: context.space.space_200,
          ),
          Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.colors.primary,
              ),
              child: const HomePageServicesContainerWidget()),
          SizedBox(
            height: context.space.space_400,
          ),
          Text(
            "Curated Original Spare Parts",
            style: context.typography.h3,
          ),
          const SpareBrandsWidget()
        ]),
      ),
    );
  }
}
