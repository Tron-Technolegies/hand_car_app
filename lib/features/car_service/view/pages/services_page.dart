import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/car_service/controller/filter_categories/service_filter.dart';
import 'package:hand_car/features/car_service/controller/service_category/service_category.dart';
import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

// Services Page

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
    final scrollController = useScrollController();
    final animationController = 
        useAnimationController(duration: const Duration(milliseconds: 500));

    // Watch the filtered services
    final filteredServicesAsyncValue = ref.watch(filteredServicesProvider);

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

      // Update selected category
      ref.read(serviceCategoryFilterProvider.notifier)
         .setCategory(services[index]);

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
          style: context.typography.h3.copyWith(color: context.colors.primaryTxt),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: context.colors.primaryTxt),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded, color: context.colors.primaryTxt),
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
          // Services Icons List
          SizedBox(
            height: context.space.space_600 * 2.6,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.space.space_50),
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      final bounce = index == 0
                          ? Curves.elasticOut.transform(animationController.value)
                          : 0.0;
                      final scale = 1.0 + (bounce * 0.2);
                      return Transform.scale(scale: scale, child: child);
                    },
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
          // Services Grid
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                buttonIndex.value = value;
                ref.read(serviceCategoryFilterProvider.notifier)
                   .setCategory(services[value]);
                scrollToIndex(value);
              },
              children: services.map((category) {
                return Builder(
                  builder: (context) => filteredServicesAsyncValue.when(
                  data: (services) => services.isEmpty
                      ? Center(child: Text('No $category services available'))
                      : GridView.builder(
                          padding: EdgeInsets.all(context.space.space_200),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            return GridViewServicesWidget(
                              image: service.images.isNotEmpty 
                                  ? service.images[0] 
                                  : Assets.images.imgPainting6.path,
                              title: service.vendorName,
                              title2: service.serviceCategory ?? '',
                              rating: '4.0', // You might want to add this to your backend
                              price: service.rate.toString(),
                              // onTap: () {
                              //   // Navigate to service detail page
                              //   // Navigator.pushNamed(context, ServiceDetailPage.route, arguments: service);
                              // },
                            );
                          },
                        ),
                  error: (error, stack) => Center(
                    child: Text('Error: ${error.toString()}'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}