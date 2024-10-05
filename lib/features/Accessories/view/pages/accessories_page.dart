import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories_circle_avatar_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories_product_card_widget.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AccessoriesPage extends HookWidget {
  static const routeName = 'accessories';
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final appBarVisible = useState(true);

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
    return Scaffold(
        key: _scaffoldKey,
        appBar: appBarVisible.value
            ? AppBar(
                backgroundColor: context.colors.white,
                leading: SvgPicture.asset(Assets.icons.handCarIcon),
                title: const Text('Accessories'),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                context.push('/cart');

                      },
                      icon: const Icon(Icons.shopping_cart_sharp)),
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                ],
              )
            : null,
        drawer: const DrawerWidget(),
        endDrawerEnableOpenDragGesture: true,
        body: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Column(children: [
            SizedBox(
              height: context.space.space_400 * 5,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AccessoriesCircleAvatharWidget(
                      onTap: () {},
                      image: Assets.images.imgCarCareAccessories.path,
                      text1: 'Maintenance &',
                      text2: 'Care',
                    ),
                    SizedBox(
                      width: context.space.space_250,
                    ),
                    AccessoriesCircleAvatharWidget(
                      onTap: () {},
                      image: Assets.images.imgCarInteriorAccessories.path,
                      text1: 'Interior',
                      text2: 'Accessories',
                    ),
                    SizedBox(
                      width: context.space.space_250,
                    ),
                    AccessoriesCircleAvatharWidget(
                      onTap: () {},
                      image: Assets.images.imgCarSpeaker.path,
                      text1: 'Electronics',
                      text2: 'Accessories',
                    ),
                    SizedBox(
                      width: context.space.space_250,
                    ),
                    AccessoriesCircleAvatharWidget(
                      onTap: () {},
                      image: Assets.images.imgCarSpeaker.path,
                      text1: 'Electronics',
                      text2: 'Accessories',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.space.space_200),
            Expanded(
              child: GridView.builder(
                controller: controller,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 340,
                  mainAxisSpacing: 0.5,
                  mainAxisExtent: 380,
                  crossAxisSpacing: 1.7,
                ),
                itemCount: 10,
                itemBuilder: (context, index) =>
                    const AccessoriesProductCardWidget(),
              ),
            ),
          ]),
        ));
  }
}
