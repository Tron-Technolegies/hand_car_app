import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/category_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_circle_avatar_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/grid_view_for_accessories_widget.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

class AccessoriesPage extends HookConsumerWidget {
  static const route = '/accessories';
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final List<String> images = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1gGXMTCuE-ZlTuR6tXgLvAxBqfyVw-_2hSQ&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnAKFsUZa2dWJ4Lym_512IUED-ICJmOydQ7w&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST_jdzAn0TttNbib1DGe119FjY-Wi_L5zc8g&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvOX4aF0GarSWiEFx7EP3sixmcfagZRL6zPg&s'
    ];
    final controller = useScrollController();
    final appBarVisible = useState(true);
    final pageController = usePageController();
    final currentPage = useState(0);
    final isSearching = useState(false);

    final searchTextController = useTextEditingController();
    final category = ref.watch(categoryControllerProvider);

    useEffect(() {
      /// Changes [appBarVisible] based on the scroll direction.
      ///
      /// If the user is scrolling down, hides the app bar.
      /// If the user is scrolling up, shows the app bar.
      void onScroll() {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          appBarVisible.value = false;
        } else if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          appBarVisible.value = true;
        }
      }

      controller.addListener(onScroll);
      return () => controller.removeListener(onScroll);
    }, [controller]);

    return Scaffold(
      key: scaffoldKey2,
      appBar: appBarVisible.value
          ? AppBar(
              backgroundColor: context.colors.white,
              title: isSearching.value
                  ? TextField(
                      controller: searchTextController,
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search Accessories',
                        hintStyle: context.typography.body,
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // FiltNaver logic here
                      },
                    )
                  : const Text('Accessories'),
              centerTitle: true,
              actions: [
                if (!isSearching.value)
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => isSearching.value = true,
                  ),
                IconButton(
                    onPressed: () {
                      context.push('/cart');
                    },
                    icon: const Icon(Icons.shopping_cart_sharp)),
                IconButton(
                    onPressed: () {
                      scaffoldKey2.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu)),
              ],
              leading: isSearching.value
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        isSearching.value = false;
                        searchTextController.clear();
                      },
                    )
                  : SvgPicture.asset('assets/icons/hand_car_icon.svg'),
            )
          : null,
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          SizedBox(
            height: context.space.space_400 * 5,
            child: category.when(
              data: (categories) => ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return AccessoriesCircleAvatharWidget(
                    text1: category.name,
                    image: images[index],
                    onTap: () {},
                  );
                },
              ),
              error: (error, _) =>
                  Center(child: Lottie.asset(Assets.animations.error)),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              children: [
                // Maintenance & Care
                // GridViewBuilderAccessoriesWidget(
                //   name: "3M Car Washer",
                //   price: '190',
                //   discount: '298',
                //   off: '30',
                //   image:
                //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJnD1gtXHviN3Ywia6uOcoAfa1XHgCsh7Zkw&s',
                // ),
                // // Interior Accessories
                // GridViewBuilderAccessoriesWidget(
                //   name: "Car Seat",
                //   price: '180',
                //   discount: '299',
                //   off: '30',
                //   image:
                //       'https://e7.pngegg.com/pngimages/372/436/png-clipart-white-and-black-vehicle-interior-car-seat-massage-chair-child-safety-seat-automotive-interior-driving-interior-design-thumbnail.png',
                // ),
                // // Electronics Accessories
                // GridViewBuilderAccessoriesWidget(
                //   name: "Unitopsci Wireless Bluetooth Speaker",
                //   price: '120',
                //   discount: '299',
                //   off: '30',
                //   image:
                //       'https://www.pngplay.com/wp-content/uploads/7/Automobile-Car-Accessories-PNG-Background.png',
                // ),
                GridViewBuilderAccessoriesWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Accessories/view/pages/product_search_page.dart';
// import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_circle_avatar_widget.dart';
// import 'package:hand_car/features/Accessories/view/widgets/accessories/grid_view_for_accessories_widget.dart';
// import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
// import 'package:hand_car/gen/assets.gen.dart';

// final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

// class AccessoriesPage extends HookConsumerWidget {
//   static const route = '/accessories';
//   const AccessoriesPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = useScrollController();
//     final appBarVisible = useState(true);
//     final pageController = usePageController(initialPage: 0);
//     final currentPage = useState(0);
//     final isSearching = useState(false);
//     final searchTextController = useTextEditingController();

//     // Listen to products state
//     final productsState = ref.watch(productsControllerProvider);

//     useEffect(() {
//       void onScroll() {
//         if (controller.position.userScrollDirection == ScrollDirection.reverse) {
//           appBarVisible.value = false;
//         } else if (controller.position.userScrollDirection == ScrollDirection.forward) {
//           appBarVisible.value = true;
//         }
//       }

//       controller.addListener(onScroll);
//       return () => controller.removeListener(onScroll);
//     }, [controller]);

//     // Search handler
//     void handleSearch(String query) {
//       ref.read(productsControllerProvider.notifier).searchProducts(query);
//     }

//     return Scaffold(
//       key: scaffoldKey2,
//       appBar: appBarVisible.value
//           ? AppBar(
//               backgroundColor: context.colors.white,
//               title: isSearching.value
//                   ? TextField(
//                       controller: searchTextController,
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         suffixIcon: const Icon(Icons.search),
//                         hintText: 'Search Accessories',
//                         hintStyle: context.typography.body,
//                         border: InputBorder.none,
//                       ),
//                       onChanged: handleSearch,
//                     )
//                   : const Text('Accessories'),
//               centerTitle: true,
//               actions: [
//                 if (!isSearching.value)
//                   IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () => isSearching.value = true,
//                   ),
//                 IconButton(
//                     onPressed: () {
//                       context.push('/cart');
//                     },
//                     icon: const Icon(Icons.shopping_cart_sharp)),
//                 IconButton(
//                     onPressed: () {
//                       scaffoldKey2.currentState?.openDrawer();
//                     },
//                     icon: const Icon(Icons.menu)),
//               ],
//               leading: isSearching.value
//                   ? IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () {
//                         isSearching.value = false;
//                         searchTextController.clear();
//                         ref.read(productsControllerProvider.notifier).searchProducts('');
//                       },
//                     )
//                   : SvgPicture.asset('assets/icons/hand_car_icon.svg'),
//             )
//           : null,
//       body: Column(
//         children: [
//           SizedBox(
//             height: context.space.space_400 * 5,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 AccessoriesCircleAvatharWidget(
//                   onTap: () => pageController.animateToPage(0,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut),
//                   image: Assets.images.imgCarCareAccessories.path,
//                   text1: 'Maintenance &',
//                   text2: 'Care',
//                 ),
//                 SizedBox(width: context.space.space_250),
//                 AccessoriesCircleAvatharWidget(
//                   onTap: () => pageController.animateToPage(1,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut),
//                   image: Assets.images.imgCarInteriorAccessories.path,
//                   text1: 'Interior',
//                   text2: 'Accessories',
//                 ),
//                 SizedBox(width: context.space.space_250),
//                 AccessoriesCircleAvatharWidget(
//                   onTap: () => pageController.animateToPage(2,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut),
//                   image: Assets.images.imgCarSpeaker.path,
//                   text1: 'Electronics',
//                   text2: 'Accessories',
//                 ),
//                 SizedBox(width: context.space.space_250),
//                 AccessoriesCircleAvatharWidget(
//                   onTap: () => pageController.animateToPage(3,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut),
//                   image: Assets.images.imgCarSpeaker.path,
//                   text1: 'Other',
//                   text2: 'Accessories',
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: productsState.when(
//               data: (products) => GridView.builder(
//   key: PageStorageKey<String>('productsGrid'),
//   controller: controller, // Ensure this is only created once
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     crossAxisSpacing: 10,
//     mainAxisSpacing: 10,
//     childAspectRatio: 0.7,
//   ),
//   itemCount: products.length,
//   itemBuilder: (context, index) {
//     final product = products[index];
//     return GridViewBuilderAccessoriesWidget(
//       key: ValueKey(product.id), // Use unique values for keys
//       name: product.name,
//       price: product.price,
//       image: product.image ?? '',
//       discount:   '', // Assuming these fields exist
//       off:  '',
//     );
//   },
// ),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, stack) => Center(
//                 child: Text('Error: $error'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }