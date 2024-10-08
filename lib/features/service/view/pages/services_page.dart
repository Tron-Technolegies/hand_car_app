import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/service/view/widgets/service_info_container_widget.dart';
import 'package:hand_car/features/service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//Services Page
class ServicesPage extends HookConsumerWidget {
  static const String route = '/services_page';
  final List<String> services = [
    "Painting",
    "Fitting",
    "Spare parts",
    "General Checkup",
    "Car Wash",
  ];

  final List<String> images = [
    Assets.icons.icPaintingService,
    Assets.icons.icFittingService,
    Assets.icons.icSparePartsService,
    Assets.icons.icGeneralCheckupService,
    Assets.icons.icWashService
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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.icons.handCarIcon),
        ),
        title: Text(
          "Our Services",
          style:
              context.typography.h3.copyWith(color: context.colors.primaryTxt),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: context.colors.primaryTxt,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_rounded,
              color: context.colors.primaryTxt,
            ),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: context.colors.primaryTxt,
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.space.space_200),
            // SizedBox(
            //   height: context.space.space_600,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: List.generate(
            //       services.length,
            //       (index) => Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: context.space.space_100),
            //         child: ServicesButtonWidget(
            //           title: services[index],
            //           selectedIndex: index,
            //           isSelected: index == buttonIndex.value,
            //           onSelectPlan: onItemTapped,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: context.space.space_600 * 2.6,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  services.length,
                  (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_100),
                      child: ServicesIconsWidget(
                        image: images[index],
                        title: services[index],
                        selectedIndex: index,
                        isSelected: index == buttonIndex.value,
                        onSelectService: onItemTapped,
                      )),
                ),
              ),
            ),
            SizedBox(height: context.space.space_100),
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
                      image: Assets.images.imgPainting.path,
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
                      title: 'Onyxaa ',
                      title2: 'Water Services',
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

