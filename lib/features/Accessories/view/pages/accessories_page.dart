import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_circle_avatar_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/grid_view_for_accessories_widget.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

class AccessoriesPage extends HookWidget {
  static const routeName = 'accessories';
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final appBarVisible = useState(true);
    final pageController = usePageController();
    final currentPage = useState(0);
    final isSearching = useState(false);

    final searchTextController = useTextEditingController();

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
                        // Filter logic here
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                AccessoriesCircleAvatharWidget(
                  onTap: () => pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  image: Assets.images.imgCarCareAccessories.path,
                  text1: 'Maintenance &',
                  text2: 'Care',
                ),
                SizedBox(width: context.space.space_250),
                AccessoriesCircleAvatharWidget(
                  onTap: () => pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  image: Assets.images.imgCarInteriorAccessories.path,
                  text1: 'Interior',
                  text2: 'Accessories',
                ),
                SizedBox(width: context.space.space_250),
                AccessoriesCircleAvatharWidget(
                  onTap: () => pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  image: Assets.images.imgCarSpeaker.path,
                  text1: 'Electronics',
                  text2: 'Accessories',
                ),
                SizedBox(width: context.space.space_250),
                AccessoriesCircleAvatharWidget(
                  onTap: () => pageController.animateToPage(3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
                  image: Assets.images.imgCarSpeaker.path,
                  text1: 'Other',
                  text2: 'Accessories',
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              children: const [
                // Maintenance & Care
                GridViewBuilderAccessoriesWidget(
                  name: "3M Car Washer",
                  price: '190',
                  discount: '298',
                  off: '30',
                  image:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJnD1gtXHviN3Ywia6uOcoAfa1XHgCsh7Zkw&s',
                ),
                // Interior Accessories
                GridViewBuilderAccessoriesWidget(
                  name: "Car Seat",
                  price: '180',
                  discount: '299',
                  off: '30',
                  image:
                      'https://e7.pngegg.com/pngimages/372/436/png-clipart-white-and-black-vehicle-interior-car-seat-massage-chair-child-safety-seat-automotive-interior-driving-interior-design-thumbnail.png',
                ),
                // Electronics Accessories
                GridViewBuilderAccessoriesWidget(
                  name: "Unitopsci Wireless Bluetooth Speaker",
                  price: '120',
                  discount: '299',
                  off: '30',
                  image:
                      'https://www.pngplay.com/wp-content/uploads/7/Automobile-Car-Accessories-PNG-Background.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
