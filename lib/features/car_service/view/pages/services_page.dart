import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/controller/filter_categories/service_filter.dart';

import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/map/map_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

// Services Page

class ServicesPage extends HookConsumerWidget {
  static const String route = '/services_page';

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
    final scrollController = useScrollController();
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));

    // Watch both services and categories
    final servicesAsync = ref.watch(carServiceControllerProvider);
    final categoriesAsync = ref.watch(serviceCategoryControllerProvider);

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

    void onItemTapped(int index, String category) {
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
            icon: Icon(Icons.search, color: context.colors.primaryTxt),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded,
                color: context.colors.primaryTxt),
          ),
          IconButton(
            onPressed: () {
              scaffoldKey3.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu, color: context.colors.primaryTxt),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          SizedBox(height: context.space.space_200),
          ServiceMapUI(),
          SizedBox(height: context.space.space_200),

          // Categories List
          categoriesAsync.when(
            data: (categories) => SizedBox(
              height: context.space.space_600 * 2.6,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.space.space_100),
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        final bounce = index == 0
                            ? Curves.elasticOut
                                .transform(animationController.value)
                            : 0.0;
                        final scale = 1.0 + (bounce * 0.2);
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: ServicesIconsWidget(
                        image:
                            index < images.length ? images[index] : images[0],
                        title: category.name,
                        selectedIndex: index,
                        isSelected: index == buttonIndex.value,
                        onSelectService: (idx) =>
                            onItemTapped(idx, category.name),
                      ),
                    ),
                  );
                },
              ),
            ),
            error: (error, _) =>
                Center(child: Text('Error loading categories')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: context.space.space_100),
          // Services Grid
          Expanded(
            child: categoriesAsync.when(
              data: (categories) => PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  buttonIndex.value = value;
                  if (value < categories.length) {
                    scrollToIndex(value);
                  }
                },
                itemCount: categories.length,
                itemBuilder: (context, categoryIndex) {
                  return servicesAsync.when(
                    data: (services) {
                      final filteredServices = services
                          .where((service) =>
                              service.serviceCategory ==
                              categories[categoryIndex].name)
                          .toList();

                      if (filteredServices.isEmpty) {
                        return Center(
                          child: Text(
                            'No ${categories[categoryIndex].name} services available',
                            style: context.typography.bodyLarge,
                          ),
                        );
                      }

                      return GridViewServicesWidget(services: filteredServices);
                    },
                    error: (error, _) => Center(
                      child: Text(
                        'Error $error services',
                        style: context.typography.bodyLarge,
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              error: (error, _) => Center(
                child: Text(
                  'Error loading categories',
                  style: context.typography.bodyLarge,
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
