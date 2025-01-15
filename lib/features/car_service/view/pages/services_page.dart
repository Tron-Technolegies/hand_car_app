// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
// import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
// import 'package:hand_car/features/car_service/controller/filter_categories/service_filter.dart';
// import 'package:hand_car/features/car_service/model/service_model.dart';
// import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
// import 'package:hand_car/features/car_service/view/widgets/map/map_widget.dart';
// import 'package:hand_car/features/car_service/view/widgets/services_icon_widget.dart';
// import 'package:hand_car/gen/assets.gen.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();

// class ServicesPage extends HookConsumerWidget {
//   static const String route = '/services_page';

//   final List<String> images = [
//     Assets.icons.icPaintingService,
//     Assets.icons.icFittingService,
//     Assets.icons.icSparePartsService,
//     Assets.icons.icGeneralCheckupService,
//     Assets.icons.icWashService
//   ];

//   ServicesPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pageController = usePageController();
//     final buttonIndex = useState(0);
//     final scrollController = useScrollController();
//     final animationController = useAnimationController(
//       duration: const Duration(milliseconds: 500),
//     );

//     final servicesAsync = ref.watch(carServiceControllerProvider);
//     final categoriesAsync = ref.watch(serviceCategoryControllerProvider);

//     void scrollToIndex(int index) {
//       final screenWidth = MediaQuery.of(context).size.width;
//       final itemWidth = screenWidth / 3;
//       final maxScroll = scrollController.position.maxScrollExtent;
//       const minScroll = 0.0;

//       double targetScroll = index * itemWidth - (screenWidth - itemWidth) / 2;
//       targetScroll = targetScroll.clamp(minScroll, maxScroll);

//       scrollController.animateTo(
//         targetScroll,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }

//     void onItemTapped(int index, String category) {
//       buttonIndex.value = index;
//       pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );

//       if (index == 0) {
//         animationController.reset();
//         animationController.forward();
//       }

//       scrollToIndex(index);
//     }

//     Widget buildServiceMap() {
//       return servicesAsync.when(
//         data: (services) {
//           if (services.isEmpty) {
//             return const SizedBox.shrink();
//           }
//           return ServiceMapUI(service: services[0]);
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(
//           child: Text('Error loading service map: $error'),
//         ),
//       );
//     }

//     return Scaffold(
//       key: scaffoldKey3,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: SvgPicture.asset(Assets.icons.handCarIcon),
//         ),
//         title: Text(
//           "Our Services",
//           style: context.typography.h3.copyWith(
//             color: context.colors.primaryTxt,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.filter_alt_rounded,
//               color: context.colors.primaryTxt,
//             ),
//           ),
//           IconButton(
//             onPressed: () => scaffoldKey3.currentState?.openDrawer(),
//             icon: Icon(
//               Icons.menu,
//               color: context.colors.primaryTxt,
//             ),
//           ),
//         ],
//       ),
//       drawer: const DrawerWidget(),
//       endDrawerEnableOpenDragGesture: true,
//       body: Column(
//         children: [
//           SizedBox(height: context.space.space_200),
//           buildServiceMap(),
//           SizedBox(height: context.space.space_200),

//           // Categories List
//           categoriesAsync.when(
//             data: (categories) => SizedBox(
//               height: context.space.space_600 * 2.6,
//               child: ListView.builder(
//                 controller: scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.space.space_100,
//                     ),
//                     child: AnimatedBuilder(
//                       animation: animationController,
//                       builder: (context, child) {
//                         final bounce = index == 0
//                             ? Curves.elasticOut.transform(
//                                 animationController.value,
//                               )
//                             : 0.0;
//                         final scale = 1.0 + (bounce * 0.2);
//                         return Transform.scale(scale: scale, child: child);
//                       },
//                       child: ServicesIconsWidget(
//                         image: index < images.length ? images[index] : images[0],
//                         title: category.name,
//                         selectedIndex: index,
//                         isSelected: index == buttonIndex.value,
//                         onSelectService: (idx) => onItemTapped(
//                           idx,
//                           category.name,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             error: (error, _) => Center(
//               child: Text('Error loading categories'),
//             ),
//             loading: () => Center(
//               child: LoadingAnimationWidget.staggeredDotsWave(
//                 color: Colors.black,
//                 size: 50,
//               ),
//             ),
//           ),
//           SizedBox(height: context.space.space_200),

//           // Services Grid
//           Expanded(
//             child: categoriesAsync.when(
//               data: (categories) => PageView.builder(
//                 controller: pageController,
//                 onPageChanged: (value) {
//                   log(serviceCategoryControllerProvider.name.toString());
//                   buttonIndex.value = value;
//                   if (value < categories.length) {
//                     scrollToIndex(value);
//                   }
//                 },
//                 itemCount: categories.length,
//                 itemBuilder: (context, categoryIndex) {
//                   return servicesAsync.when(
//                     data: (services) {
//                       final filteredServices = services.where(
//                         (service) =>
//                             service.serviceCategory ==
//                             categories[categoryIndex].name,
//                       ).toList();

//                       if (filteredServices.isEmpty) {
//                         return Center(
//                           child: Text(
//                             'No ${categories[categoryIndex].name} services available',
//                             style: context.typography.bodyLarge,
//                           ),
//                         );
//                       }

//                       return GridViewServicesWidget(
//                         services: filteredServices,
//                       );
//                     },
//                     error: (error, _) => Center(
//                       child: Text(
//                         'Error loading services: $error',
//                         style: context.typography.bodyLarge,
//                       ),
//                     ),
//                     loading: () => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 },
//               ),
//               error: (error, _) => Center(
//                 child: Text(
//                   'Error loading categories',
//                   style: context.typography.bodyLarge,
//                 ),
//               ),
//               loading: () => const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/car_service/controller/car_service_controller.dart';
import 'package:hand_car/features/car_service/controller/filter_categories/service_filter.dart';
import 'package:hand_car/features/car_service/controller/location/location_list/location_list.dart';
import 'package:hand_car/features/car_service/controller/location/location_notifier/location_notifier.dart';
import 'package:hand_car/features/car_service/controller/location/search/location_search_controller.dart';
import 'package:hand_car/features/car_service/model/location/location_model.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/widgets/grid_view_service_widget.dart';
import 'package:hand_car/features/car_service/view/widgets/map/map_widget.dart';
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
    final searchController = useTextEditingController();
    final showSearchResults = useState(false);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final servicesAsync = ref.watch(carServiceControllerProvider);
    final categoriesAsync = ref.watch(serviceCategoryControllerProvider);
    final locationState = ref.watch(locationNotifierProvider);
    final searchResults = ref.watch(searchNotifierProvider);
    final servicesState = ref.watch(servicesNotifierProvider);

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

    // Build search bar
    Widget buildSearchBar() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: context.space.space_200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                showSearchResults.value = value.isNotEmpty;
                ref.read(searchNotifierProvider.notifier).searchLocation(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for locations',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          showSearchResults.value = false;
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            if (showSearchResults.value)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: searchResults.when(
                  data: (results) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(result.displayName),
                        subtitle: Text(result.address ?? ''),
                        onTap: () async {
                          showSearchResults.value = false;
                          searchController.text = result.displayName;
                          
                          // Fetch nearby services for the selected location
                          await ref
                              .read(servicesNotifierProvider.notifier)
                              .fetchNearbyServices(
                                result.latLng.latitude,
                                result.latLng.longitude,
                              );
                        },
                      );
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => ListTile(
                    leading: const Icon(Icons.error, color: Colors.red),
                    title: Text('Error: $error'),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // Build services grid with location-based filtering
    Widget buildServicesGrid(List<ServiceModel> services, String categoryName) {
      // Handle loading state
      if (servicesState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      // Handle error state
      if (servicesState.error != null) {
        return Center(
          child: Text(
            servicesState.error!,
            style: context.typography.bodyLarge,
          ),
        );
      }

      // Filter services by category first
      final filteredByCategory = services.where(
        (service) => service.serviceCategory == categoryName
      ).toList();

      // If no services in category
      if (filteredByCategory.isEmpty) {
        return Center(
          child: Text(
            'No $categoryName services available',
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
        );
      }

      // If location search is active
      if (showSearchResults.value && servicesState.services.isNotEmpty) {
        // Find services that exist in the nearby services list
        final nearbyServices = filteredByCategory.where((service) {
          return servicesState.services.any((nearbyService) => 
            nearbyService.name == service.vendorName && 
            nearbyService.distance <= 50
          );
        }).toList();

        // If no nearby services found
        if (nearbyServices.isEmpty) {
          return Center(
            child: Text(
              'No $categoryName services available in the selected location',
              style: context.typography.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }

        // Sort services by distance
        nearbyServices.sort((a, b) {
          final distanceA = servicesState.services
              .firstWhere(
                (s) => s.name == a.vendorName,
                orElse: () => const ServiceLocation(
                  name: '',
               
                  distance: double.infinity,
                  latitude: 0,
                  longitude: 0,
                ),
              )
              .distance;

          final distanceB = servicesState.services
              .firstWhere(
                (s) => s.name == b.vendorName,
                orElse: () => const ServiceLocation(
                  name: '',
                  
                  distance: double.infinity,
                  latitude: 0,
                  longitude: 0,
                ),
              )
              .distance;

          return distanceA.compareTo(distanceB);
        });

        // Return grid with nearby services and location info
        return GridViewServicesWidget(
          services: nearbyServices,
          locationServices: servicesState.services,
        );
      }

      // Return all services in category if no location search
      return GridViewServicesWidget(
        services: filteredByCategory,
        locationServices: const [],
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
          IconButton(
            onPressed: () => ref.read(locationNotifierProvider.notifier).getCurrentLocation(),
            icon: Icon(
              Icons.my_location,
              color: context.colors.primaryTxt,
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
          if (locationState.error != null)
            Container(
              padding: EdgeInsets.all(context.space.space_200),
              color: Colors.red.withOpacity(0.1),
              child: Text(
                locationState.error!,
                style: context.typography.bodyMedium.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          SizedBox(height: context.space.space_200),
          buildSearchBar(),
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
                        image: index < images.length ? images[index] : images[0],
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
                      final filteredServices = services.where(
                        (service) =>
                            service.serviceCategory ==
                            categories[categoryIndex].name,
                      ).toList();

                      return buildServicesGrid(
                        filteredServices,
                        categories[categoryIndex].name,
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