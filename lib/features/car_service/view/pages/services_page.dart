import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/controller/filter_categories/service_filter.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/location_notifier/location_notifier.dart';
import 'package:hand_car/features/car_service/controller/rating/rating_filter/rating_filter.dart';
import 'package:hand_car/features/car_service/view/widgets/grid/location_based_grid_view.dart';
import 'package:hand_car/features/car_service/view/widgets/map/location_search_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/map/location_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/rating/rating_filter_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/services_icon_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

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
    final showNearbyServices = useState(false);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    // Providers
    final servicesAsync = ref.watch(carServiceControllerProvider);
    final categoriesAsync = ref.watch(serviceCategoryControllerProvider);
    final locationState = ref.watch(locationNotifierProvider);
    final servicesState = ref.watch(servicesNotifierProvider);
    final selectedRating = ref.watch(ratingFilterControllerProvider);

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

    void showFilterBottomSheet() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const RatingFilterWidget(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    Widget buildFilterChip() {
      if (selectedRating == null) {
        return const Icon(
          Icons.filter_alt_outlined,
          size: 24,
          color: Colors.black,
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: context.colors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              '${selectedRating.toInt()}+',
              style: context.typography.bodySmall.copyWith(
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildNearbyServicesList() {
      if (servicesState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (servicesState.services.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No services found nearby',
            style: context.typography.bodyMedium,
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nearby Services',
                  style: context.typography.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => showNearbyServices.value = false,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicesState.services.length,
            itemBuilder: (context, index) {
              final service = servicesState.services[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.store),
                  title: Text(service.vendorName),
                  subtitle: Text(
                    '${service.distance!.toStringAsFixed(1)} km away',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle service selection
                  },
                ),
              );
            },
          ),
        ],
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
          style: context.typography.h3.copyWith(
            color: context.colors.primaryTxt,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: showFilterBottomSheet,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: buildFilterChip(),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => scaffoldKey3.currentState?.openDrawer(),
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
          const SizedBox(height: 16),
          if (locationState.error != null)
            Container(
              padding: EdgeInsets.all(context.space.space_200),
              color: Colors.red.withValues(alpha:0.1),
              child: Text(
                locationState.error!,
                style: context.typography.bodyMedium.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          LocationSearchWidget(),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(context.space.space_200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  LocationWidget(() async {
                    try {
                      if (locationState.position != null) {
                        showNearbyServices.value = true;
                        await ref
                            .read(locationNotifierProvider.notifier)
                            .getCurrentLocation();
                        if (locationState.position != null) {}
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enable location services'),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      log(e.toString());
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                          ),
                        );
                      }
                    }
                  }),
                  if (showNearbyServices.value) ...[
                    const SizedBox(height: 16),
                    buildNearbyServicesList(),
                  ],
                ],
              ),
            ),
          ),
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
                      horizontal: context.space.space_100,
                    ),
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        final bounce = index == 0
                            ? Curves.elasticOut.transform(
                                animationController.value,
                              )
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
                        onSelectService: (idx) => onItemTapped(
                          idx,
                          category.name,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            error: (error, _) => Center(
              child: Text('Error loading categories: $error'),
            ),
            loading: () => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 50,
              ),
            ),
          ),

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
                          .where(
                            (service) =>
                                service.serviceCategory ==
                                categories[categoryIndex].name,
                          )
                          .toList();

                      return LocationBasedGridView(
                        categoryName: categories[categoryIndex].name,
                        services: filteredServices,
                      );
                    },
                    error: (error, _) => Center(
                      child: Text(
                        'Error loading services: $error',
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
                  'Error loading categories: $error',
                  style: context.typography.bodyLarge,
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}