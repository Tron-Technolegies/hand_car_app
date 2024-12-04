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

// Provider to track selected category name
final selectedCategoryNameProvider = StateProvider<String?>((ref) => null);

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
                        // Search logic here
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
                    onPressed: () => context.push('/cart'),
                    icon: const Icon(Icons.shopping_cart_sharp)),
                IconButton(
                    onPressed: () => scaffoldKey2.currentState?.openDrawer(),
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
                separatorBuilder: (context, index) => const SizedBox(width: 10),
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
                      ref.read(selectedCategoryNameProvider.notifier).state = category.name;
                    },
                  );
                },
              ),
              error: (error, _) => Center(child: Lottie.asset(Assets.animations.error)),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
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
              ) ?? 0,
              itemBuilder: (context, index) {
                return category.when(
                  data: (categories) {
                    return GridViewBuilderAccessoriesWidget(
                      categoryName: categories[index].name,
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
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