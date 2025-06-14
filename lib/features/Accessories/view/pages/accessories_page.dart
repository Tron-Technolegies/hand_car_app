import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/category_controller.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/model/products/category/category_model.dart';
import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_circle_avatar_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/filter_dialog.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/grid_view_for_accessories_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badges;

final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

// Provider to track selected category name
final selectedCategoryNameProvider = StateProvider<String?>((ref) => 'All Products');
final searchQueryProvider = StateProvider<String>((ref) => '');

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
                context.push('/login');
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
    // List of image URLs (including one for "All Products")
    final List<String> images = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1gGXMTCuE-ZlTuR6tXgLvAxBqfyVw-_2hSQ&s', // All Products
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnAKFsUZa2dWJ4Lym_512IUED-ICJmOydQ7w&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST_jdzAn0TttNbib1DGe119FjY-Wi_L5zc8g&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvOX4aF0GarSWiEFx7EP3sixmcfagZRL6zPg&s',
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
    final debounceTimer = useState<Timer?>(null);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryNameProvider);

    // Debounced search
    void onSearchChanged(String query) {
      ref.read(searchQueryProvider.notifier).state = query;
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        ref.read(productsControllerProvider.notifier).searchProducts(query);
      });
    }

    useEffect(() {
      return () {
        debounceTimer.value?.cancel();
        debounceTimer.value = null;
      };
    }, []);

    useEffect(() {
      void onScroll() {
        if (controller.position.userScrollDirection == ScrollDirection.reverse) {
          appBarVisible.value = false;
        } else if (controller.position.userScrollDirection == ScrollDirection.forward) {
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
      key: scaffoldKey2,
      appBar: appBarVisible.value
          ? AppBar(
              title: isSearching.value
                  ? TextField(
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        hintText: 'Search products...',
                        border: InputBorder.none,
                      ),
                      onChanged: onSearchChanged,
                    )
                  : const Text('Accessories'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(isSearching.value ? Icons.close : Icons.search),
                  onPressed: () {
                    isSearching.value = !isSearching.value;
                    if (!isSearching.value) {
                      searchTextController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                      ref.read(productsControllerProvider.notifier).searchProducts('');
                    }
                  },
                ),
                if (isAuthenticated)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(end: 0, top: 0),
                    badgeContent: Text(
                      cartItems.when(
                        data: (cart) => cart.cartItems.fold<int>(
                              0,
                              (sum, item) => sum + item.quantity,
                            ).toString(),
                        loading: () => '...',
                        error: (_, __) => '0',
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      elevation: 2,
                    ),
                    child: IconButton(
                      onPressed: () => context.push(ShoppingCartScreen.route),
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                if (!isAuthenticated)
                  IconButton(
                    onPressed: () => _showLoginDialog(context),
                    icon: const Icon(Icons.shopping_cart_sharp),
                  ),
                IconButton(
                  onPressed: () => context.push(WishlistScreen.route),
                  icon: const Icon(Icons.favorite_border_outlined),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProductsFilterDialog(
                        onApplyFilters: (filters) {
                          ref.read(productsControllerProvider.notifier).applyFilters(filters);
                        },
                      ),
                    );
                  },
                ),
              ],
              leading: isSearching.value
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        isSearching.value = false;
                        searchTextController.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                        ref.read(productsControllerProvider.notifier).searchProducts('');
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(context.space.space_100),
                      child: SvgPicture.asset('assets/icons/hand_car_icon.svg'),
                    ),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: context.space.space_400 * 5,
              child: category.when(
                data: (categories) {
                  // Add "All Products" as the first category
                  final allCategories = [
                    Category(id: 0, name: 'All Products'),
                    ...categories,
                  ];
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: allCategories.length,
                    itemBuilder: (context, index) {
                      final category = allCategories[index];
                      return AccessoriesCircleAvatharWidget(
                        text1: category.name,
                        image: images[index % images.length],
                        onTap: () {
                          log('Selected category: ${category.name}');
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          ref.read(selectedCategoryNameProvider.notifier).state = category.name;
                          
                          // Apply category filter (null for "All Products")
                          ref.read(productsControllerProvider.notifier).applyFilters(
                                ProductsFilterState(
                                  categoryId: category.id == 0 ? null : category.id.toString(),
                                ),
                              );
                        },
                      );
                    },
                  );
                },
                error: (error, _) => Center(child: Lottie.asset(Assets.animations.error)),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
                category.whenOrNull(
                  data: (categories) {
                    final allCategories = [Category(id: 0, name: 'All Products'), ...categories];
                    ref.read(selectedCategoryNameProvider.notifier).state = allCategories[index].name;
                    
                    // Apply category filter
                    ref.read(productsControllerProvider.notifier).applyFilters(
                          ProductsFilterState(
                            categoryId: allCategories[index].id == 0 ? null : allCategories[index].id.toString(),
                          ),
                        );
                  },
                );
              },
              itemCount: category.whenOrNull(data: (categories) => categories.length + 1) ?? 0,
              itemBuilder: (context, index) {
                return category.when(
                  data: (categories) {
                    final allCategories = [Category(id: 0, name: 'All Products'), ...categories];
                    final selectedCategory = allCategories[index];
                    return products.when(
                      data: (productsList) {
                        return GridViewBuilderAccessoriesWidget(
                          categoryName: selectedCategory.name,
                          products: productsList,
                          onProductTap: (product) {
                            context.push(
                              '${AccessoriesDetailsPage.route}/${product.id}',
                              extra: product,
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Center(child: Lottie.asset(Assets.animations.error)),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Lottie.asset(Assets.animations.error)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}