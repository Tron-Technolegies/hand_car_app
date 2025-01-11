import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

// Services Page
class ServicesPage extends HookConsumerWidget {
  static const String route = '/services_page';
//List of services
  final List<String> services = [
    "Painting",
    "Fitting",
    "Spare parts",
    "General Checkup",
    "Car Wash",
  ];
//List of images for services
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
    //page controller
    final pageController = usePageController();
    //button index
    final buttonIndex = useState(0);
    //scroll controller
    final scrollController = useScrollController();
    //animation controller
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));

//scroll to index
    void scrollToIndex(int index) {
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = screenWidth / 3;
      final maxScroll = scrollController.position.maxScrollExtent;
      const minScroll = 0.0;

      double targetScroll = index * itemWidth - (screenWidth - itemWidth) / 2;
      targetScroll = targetScroll.clamp(minScroll, maxScroll);

      scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    //on item tapped for Page changing
    void onItemTapped(int index) {
      buttonIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      if (index == 0) {
        animationController.reset();
        animationController.forward();
      }

      scrollToIndex(index);
    }

    return Scaffold(
      key: scaffoldKey3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.icons.handCarIcon,
          ),
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
              scaffoldKey3.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: context.colors.primaryTxt,
            ),
          ),
        ],
      ),
      // Drawer Widget
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          SizedBox(height: context.space.space_200),
          SizedBox(
            height: context.space.space_600 * 2.6,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_50),
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      final bounce = index == 0
                          ? Curves.elasticOut
                              .transform(animationController.value)
                          : 0.0;
                      final scale = 1.0 + (bounce * 0.2);
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    //ServicesIconsWidget for list of icons
                    child: ServicesIconsWidget(
                      image: images[index],
                      title: services[index],
                      selectedIndex: index,
                      isSelected: index == buttonIndex.value,
                      onSelectService: onItemTapped,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: context.space.space_100),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                buttonIndex.value = value;
                scrollToIndex(value);
              },
              children: [
                GridViewServicesWidget(
                  image: Assets.images.imgPainting6.path,
                  title: 'ICON Rocklear',
                  title2: 'Painting Solution',
                  rating: '4.0',
                  price: '99',
                ),
                GridViewServicesWidget(
                  title: "ARM Fittings",
                  title2: "Solution",
                  rating: "4.0",
                  price: "99",
                  image: Assets.images.imgPainting2.path,
                ),
                GridViewServicesWidget(
                  image: Assets.images.imgPainting3.path,
                  title: 'Leo Spare Parts',
                  title2: 'Spare Solution',
                  rating: '4.0',
                  price: '99',
                ),
                GridViewServicesWidget(
                  image: Assets.images.imgPainting4.path,
                  title: 'General Motors',
                  title2: 'Checkup Solution',
                  rating: '4.0',
                  price: '99',
                ),
                GridViewServicesWidget(
                  image: Assets.images.imgPainting5.path,
                  title: 'Onyxa Car wash',
                  title2: 'Checkup Solution',
                  rating: '4.0',
                  price: '99',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
