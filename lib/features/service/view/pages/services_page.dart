import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
import 'package:hand_car/features/service/view/widgets/service_button_widget.dart';
import 'package:hand_car/features/service/view/widgets/service_info_container_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

//Services Page
class ServicesPage extends HookConsumerWidget {
  static const String route = '/services';
  final List<String> services = [
    "Painting",
    "Fitting",
    "Spare parts",
    "General Checkup",
  ];

  ServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final buttonIndex = useState(0);

    //Page changing function
    void onItemTapped(int index) {
      buttonIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicePlanScreen(),
                ));
          },
          icon: Lottie.asset(
            Assets.animations.premiumService,
            height: 40,
            width: 40,
          ),
        ),
        title: Text(
          "Our Services",
          style: context.typography.h2.copyWith(color: context.colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: context.colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_rounded,
              color: context.colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.space.space_200),
            SizedBox(
              height: context.space.space_500,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  services.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.space.space_100),
                    child: ServicesButtonWidget(
                      title: services[index],
                      selectedIndex: index,
                      isSelected: index == buttonIndex.value,
                      onSelectPlan: onItemTapped,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: context.space.space_200),
            SizedBox(
              height: 600,
              //PageView For Services
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  buttonIndex.value = value;
                },
                children: [
                  //Painting
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320,
                      mainAxisSpacing: 0.2,
                      mainAxisExtent: 380,
                      crossAxisSpacing: 0.3,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => PaintSolutionCard(
                      image: Assets.images.imgPainting1.path,
                      title: 'ICON Rocklear',
                      title2: 'Paint Solution',
                      rating: '4.0',
                      price: '99',
                    ),
                  ),
                  //Fitting
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320,
                      mainAxisSpacing: 0.2,
                      mainAxisExtent: 380,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => PaintSolutionCard(
                      image: Assets.images.imgPainting2.path,
                      title: 'ARM Fittings',
                      title2: 'Fitting Solution',
                      rating: '4.0',
                      price: '109',
                    ),
                  ),
                  //Spare Parts
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320,
                      mainAxisSpacing: 0.2,
                      mainAxisExtent: 380,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => PaintSolutionCard(
                      image: Assets.images.imgPainting3.path,
                      title: 'Leo Spare Parts',
                      title2: 'Spare Solution',
                      rating: '4.0',
                      price: '99',
                    ),
                  ),
                  //General Checkup
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320,
                      mainAxisSpacing: 0.2,
                      mainAxisExtent: 400,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => PaintSolutionCard(
                      image: Assets.images.imgPainting4.path,
                      title: 'General Motors',
                      title2: 'Checkup Solution',
                      rating: '4.0',
                      price: '99',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
