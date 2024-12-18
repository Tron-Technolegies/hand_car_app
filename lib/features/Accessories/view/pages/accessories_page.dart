import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/category_controller.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_circle_avatar_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/grid_view_for_accessories_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badges;

final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

// Provider to track selected category name
final selectedCategoryNameProvider = StateProvider<String?>((ref) => null);

class AccessoriesPage extends HookConsumerWidget {
  static const route = '/accessories';
  const AccessoriesPage({super.key});
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content: const Text('Please login to access the shopping cart'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to login page - replace with your login route
                // context.push('/login');
              },
              child: const Text('Login'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final products = ref.watch(productsControllerProvider);

    final cartItems = ref.watch(cartControllerProvider);
    // final authState = ref.watch(authControllerProvider);

    useEffect(() {
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

    final authState = ref.watch(authControllerProvider);
    final isAuthenticated = authState.whenOrNull(
          data: (auth) => auth?.isAuthenticated ?? false,
        ) ??
        false;

    return Scaffold(
      appBar: appBarVisible.value
          ? AppBar(
              // ... other AppBar properties ...
              title: const Text('Accessories'),
              centerTitle: true,
              actions: [
                if (!isSearching.value)
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => isSearching.value = true,
                  ),
                // Show cart button based on authentication state
                if (isAuthenticated)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(end: 0, top: 0),
                    badgeContent: Text(
                      cartItems.when(
                        data: (cart) {
                          // Calculate total quantity of items in the cart
                          final totalQuantity = cart.cartItems.fold<int>(
                            0,
                            (sum, item) => sum + item.quantity,
                          );
                          return totalQuantity.toString();
                        },
                        loading: () => '...',
                        error: (_, __) => '0',
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      elevation: 2,
                    ),
                    child: IconButton(
                      onPressed: () => context.push(ShoppingCartScreen.route),
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                if (!isAuthenticated)
                  IconButton(
                    onPressed: () =>
                        _showLoginDialog(context), // Show login dialog
                    icon: const Icon(Icons.shopping_cart_sharp),
                  ),
                IconButton(
                    onPressed: () {
                      context.push(WishlistScreen.route);
                    },
                    icon: Icon(Icons.favorite_border_outlined))
              ],
              leading: isSearching.value
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        isSearching.value = false;
                        searchTextController.clear();
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(context.space.space_100),
                      child: SvgPicture.asset('assets/icons/hand_car_icon.svg'),
                    ),
            )
          : null,
      // appBar: CustomAppBar(title: 'Accessories'),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: context.space.space_400 * 5,
              child: category.when(
                data: (categories) => ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return AccessoriesCircleAvatharWidget(
                      text1: category.name,
                      image: images[index],
                      onTap: () {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        ref.read(selectedCategoryNameProvider.notifier).state =
                            category.name;
                      },
                    );
                  },
                ),
                error: (error, _) =>
                    Center(child: Lottie.asset(Assets.animations.error)),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          // Show the page view
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
                category.whenOrNull(
                  data: (categories) {
                    ref.read(selectedCategoryNameProvider.notifier).state =
                        categories[index].name;
                  },
                );
              },
              itemCount: category.whenOrNull(
                    data: (categories) => categories.length,
                  ) ??
                  0,
              itemBuilder: (context, index) {
                return category.when(
                  data: (categories) {
                    final selectedCategory = categories[index];
                    // Access the products for the selected category
                    return products.when(
                      data: (productsList) {
                        productsList
                            .where(
                                (product) => product.id == selectedCategory.id)
                            .toList();
                        return GridViewBuilderAccessoriesWidget(
                          categoryName: selectedCategory.name,
                          onProductTap: (product) {
                            context.push(
                              '${AccessoriesDetailsPage.route}/${product.id}',
                              extra: product,
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Center(
                        child: Lottie.asset(Assets.animations.error),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Lottie.asset(Assets.animations.error),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
