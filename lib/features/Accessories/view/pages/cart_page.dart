import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_product_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/total_amount_section_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_input_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class ShoppingCartScreen extends HookConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartControllerProvider);
    final controller = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: context.typography.h3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.space.space_200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Check if cartController has data or is still loading
                cartController.when(
                  data: (cart) {
                    // If cart is empty
                    if (cart?.cartItems.isEmpty ?? true) {
                      return Center(
                          child: Column(
                        children: [
                          Lottie.asset(Assets.animations.emptyCart,
                              repeat: false),
                          Text(
                            "Your cart is empty",
                            style: context.typography.h3
                                .copyWith(color: context.colors.primaryTxt),
                          ),
                        ],
                      ));
                    }

                    // Display cart items
                    return ListView.builder(
                      itemCount: cart?.cartItems.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = cart?.cartItems[index];
                        return ProductCard(
                          productName: item?.name ?? '',
                          price: item?.price ?? 0,
                          quantity: item?.quantity.toString() ?? '',
                          // Handle update or remove actions if needed
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Lottie.asset(
                      Assets.animations.loading,
                    ),
                  ),
                  error: (error, _) => Center(
                      child: Column(
                    children: [
                      Lottie.asset(
                        Assets.animations.error,
                      ),
                      Text("Failed to load cart",
                          style: context.typography.h3
                              .copyWith(color: context.colors.primaryTxt)),
                    ],
                  )),
                ),

                SizedBox(height: context.space.space_200),
                Padding(
                  padding: EdgeInsets.only(left: context.space.space_300),
                  child: Text(
                    "Available Coupons",
                    style: context.typography.bodyLarge
                        .copyWith(color: const Color(0xff979797)),
                  ),
                ),
                SizedBox(height: context.space.space_100),

                // Coupon Input Section
                CouponInputSection(controller: controller),

                // Total Summary Section (Ensure cartController has data before accessing totalPrice)
                cartController.when(
                  data: (cart) => TotalAMountSectionWidget(
                    grandTotal: cart?.totalPrice ?? 0,
                    delivery: 0,
                    total: cart?.totalPrice ?? 0,
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: cartController.when(
        data: (cart) => Padding(
          padding:  EdgeInsets.all(context.space.space_200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Grand Total: AED ${cart?.totalPrice ?? 0}',
                  style: context.typography.bodyMedium),
              ButtonWidget(
                label: 'Proceed To Pay',
                onTap: () {
                  context.go('/checkout');
                },
              ),
            ],
          ),
        ),
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
