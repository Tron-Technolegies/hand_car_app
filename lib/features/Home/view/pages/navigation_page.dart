import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/utils/bottom_nav_controller.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Home/view/pages/home_page.dart';
import 'package:hand_car/features/Authentication/view/pages/profile_page.dart';
import 'package:hand_car/features/SpareParts/view/pages/spares_page.dart';
import 'package:hand_car/features/car_service/view/pages/services_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Home/view/widgets/bottom_app_bar.dart';

/// Navigation Page
class NavigationPage extends HookConsumerWidget {
  static const String route = '/navigation';

  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the navigation state from the provider.
    final navigationState = ref.watch(navigationProvider);
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // Listen for page changes and update the provider.
    useEffect(() {
      navigationState.pageController.addListener(() {
        if (navigationState.pageController.page != null) {
          ref.read(navigationProvider.notifier).changeSelectedItemIndex(
              navigationState.pageController.page!.round());
        }
      });
      return () => navigationState.pageController.dispose();
    }, const []);

    // Ensure the controller jumps to the correct page after being built.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigationState.pageController.hasClients) {
          navigationState.pageController
              .jumpToPage(navigationState.selectedNavBarItemIndex);
        }
      });
      return null;
    }, [navigationState.selectedNavBarItemIndex]);

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: navigationState.pageController,
        children: [
          ServicesPage(), // Index 0
          const AccessoriesPage(), // Index 1
          const HomePage(), // Index 2 (Center)
          const AutoPartsPage(), // Index 3
          const ProfilePage(), // Index 4
        ],
        onPageChanged: (index) => ref
            .read(navigationProvider.notifier)
            .changeSelectedItemIndex(index),
      ),
      bottomNavigationBar: keyboardVisible
          ? null
          : Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DockingBar(
                  currentIndex: navigationState.selectedNavBarItemIndex,
                  onTap: (index) => ref
                      .read(navigationProvider.notifier)
                      .changeSelectedItemIndex(index),
                  context: context,
                ),
              ),
            ),
    );
  }
}
