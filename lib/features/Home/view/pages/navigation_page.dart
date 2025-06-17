import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/bottom_nav_controller.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Authentication/view/pages/profile_page.dart';
import 'package:hand_car/features/Home/view/pages/home_page.dart';
import 'package:hand_car/features/SpareParts/view/pages/spares_page.dart';
import 'package:hand_car/features/Subscriptions/view/pages/subscription_page.dart';
import 'package:hand_car/features/car_service/view/pages/services_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationPage extends HookConsumerWidget {
  static const String route = '/navigation';

  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    useEffect(() {
      navigationState.pageController.addListener(() {
        if (navigationState.pageController.page != null) {
          ref.read(navigationProvider.notifier).changeSelectedItemIndex(
              navigationState.pageController.page!.round());
        }
      });
      return () => navigationState.pageController.dispose();
    }, const []);

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
          ServicesPage(),
          AccessoriesPage(),
          HomePage(),
          AutoPartsPage(),
          SubscriptionPage(),
        ],
        onPageChanged: (index) => ref
            .read(navigationProvider.notifier)
            .changeSelectedItemIndex(index),
      ),
      bottomNavigationBar: keyboardVisible
          ? null
          : BottomNavigationBar(
              currentIndex: navigationState.selectedNavBarItemIndex,
              onTap: (index) => ref
                  .read(navigationProvider.notifier)
                  .changeSelectedItemIndex(index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: context.colors.primary,
              backgroundColor: Colors.white,
              elevation: 10,
              items: [
                _buildNavItem(
                  context: context,
                  iconName: 'ic_car_service',
                  label: 'Service',
                  isSelected: navigationState.selectedNavBarItemIndex == 0,
                ),
                _buildNavItem(
                  context: context,
                  iconName: 'ic_car_seat',
                  label: 'Accessories',
                  isSelected: navigationState.selectedNavBarItemIndex == 1,
                ),
                _buildNavItem(
                  context: context,
                  iconName: 'garage',
                  label: 'Home',
                  isSelected: navigationState.selectedNavBarItemIndex == 2,
                ),
                _buildNavItem(
                  context: context,
                  iconName: 'ic_spare',
                  label: 'Auto Parts',
                  isSelected: navigationState.selectedNavBarItemIndex == 3,
                ),
                _buildNavItem(
                  context: context,
                  iconName: 'ic_subscription',
                  label: 'Subscription',
                  isSelected: navigationState.selectedNavBarItemIndex == 4,
                ),
              ],
            ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      {required String iconName,
      required String label,
      required bool isSelected,
      required BuildContext context}) {
    String iconPath = isSelected
        ? 'assets/icons/${iconName}_filled.svg'
        : 'assets/icons/${iconName}_outline.svg';

    if (iconName == 'garage') {
      iconPath = isSelected ? Assets.icons.garageFilled : Assets.icons.garage;
    }

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 24,
        colorFilter: ColorFilter.mode(
          isSelected ? context.colors.primary : context.colors.primaryTxt,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
