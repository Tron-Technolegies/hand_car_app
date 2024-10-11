import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/service/view/widgets/grid_view_service_widget.dart';
import 'package:hand_car/features/service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

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
    final controller = useScrollController();

    void onItemTapped(int index) {
      buttonIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      key: scaffoldKey3,
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
              scaffoldKey3.currentState?.openDrawer();
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
      body: Column(
        children: [
          SizedBox(height: context.space.space_200),
          SizedBox(
            height: context.space.space_600 * 2.6,
            child: ListView(
            
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                services.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.space.space_50),
                  child: ServicesIconsWidget(
                    image: images[index],
                    title: services[index],
                    selectedIndex: index,
                    isSelected: index == buttonIndex.value,
                    onSelectService: onItemTapped,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.space.space_100),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                buttonIndex.value = value;
              },
              
              children: [
                GridViewServicesWidget(
                  image: Assets.images.imgPainting1.path,
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

