
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/pages/accessories_page.dart';
import 'package:hand_car/features/Home/view/pages/home_page.dart';
import 'package:hand_car/features/Home/view/pages/services_page.dart';
import 'package:hand_car/features/Home/view/pages/spares_page.dart';
import 'package:hand_car/features/Subscriptions/view/pages/car_wash_subscription.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationPage extends HookConsumerWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final pageController = usePageController();
    final navBarIndex = useState(0);

    void onItemTapped(int index) {
      navBarIndex.value = index;
      pageController.jumpToPage(index);
    }
    
    return Scaffold(

    body: PageView(
      onPageChanged: (index) {
        navBarIndex.value=index;
      },
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
         HomePage(),
        SparesPage(),
        AccessoriesPage(),
        ServicesPage(),
        CarWashPlanScreen()
      ],
    ),

bottomNavigationBar: BottomNavigationBar(
  selectedItemColor: context.colors.primary,
  type: BottomNavigationBarType.fixed,
  currentIndex: navBarIndex.value,
  onTap: onItemTapped,
  backgroundColor: Colors.white,
  items: [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        navBarIndex.value == 0
            ? Assets.icons.icHomeFilled
            : Assets.icons.icHomeOutline,
        height: 30,
        colorFilter: navBarIndex.value == 0
            ? ColorFilter.mode(
                context.colors.primary, BlendMode.srcIn)
            : ColorFilter.mode(
                context.colors.containerShadow, BlendMode.srcIn),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        navBarIndex.value == 1
            ? Assets.icons.icSpareFilled
            : Assets.icons.icSpareOutline,
        height: 30,
        colorFilter: navBarIndex.value == 1
            ? ColorFilter.mode(
                context.colors.primary, BlendMode.srcIn)
            : ColorFilter.mode(
                context.colors.containerShadow, BlendMode.srcIn),
      ),
      label: 'Spares',
    ),
       BottomNavigationBarItem(
      icon: SvgPicture.asset(
        navBarIndex.value == 2
            ? Assets.icons.icCarSeatFilled
            : Assets.icons.icCarSeatOutline,
        height: 30,
        colorFilter: navBarIndex.value == 2
            ? ColorFilter.mode(
                context.colors.primary, BlendMode.srcIn)
            : ColorFilter.mode(
                context.colors.containerShadow, BlendMode.srcIn),
      ),
      label: 'Accessories',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        navBarIndex.value == 3
            ? Assets.icons.icCarServiceFilled
            : Assets.icons.icCarServiceOutline,
        height: 30,
        colorFilter: navBarIndex.value == 3
            ? ColorFilter.mode(
                context.colors.primary, BlendMode.srcIn)
            : ColorFilter.mode(
                context.colors.containerShadow, BlendMode.srcIn),
      ),
      label: 'Service',
    ),
    
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        navBarIndex.value == 4
            ? Assets.icons.icSubscriptionFilled
            : Assets.icons.icSubscriptionOutline,
        height: 30,
        colorFilter: navBarIndex.value == 4
            ? ColorFilter.mode(
                context.colors.primary, BlendMode.srcIn)
            : ColorFilter.mode(
                context.colors.containerShadow, BlendMode.srcIn),
      ),
      label: 'Subscription',
    ),
  ],
),


    );
  }
}