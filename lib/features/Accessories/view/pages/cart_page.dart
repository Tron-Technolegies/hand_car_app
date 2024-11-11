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
        title: Text('Your Shopping Cart', style: context.typography.h3),
        actions: [
          if (cartController.asData?.value.cartItems.isNotEmpty ?? false)
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                ref.read(cartControllerProvider.notifier).clearCart();
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.space.space_200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart data or loading/error display
                cartController.when(
                  data: (cart) {
                    if (cart.cartItems.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(Assets.animations.emptyCart, repeat: false),
                              Text(
                                "Your cart is empty",
                                style: context.typography.h3.copyWith(color: context.colors.primaryTxt),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: cart.cartItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = cart.cartItems[index];
                        return ProductCard(
                          productName: item.productName,
                          price: item.productPrice,
                          quantity: item.quantity.toString(),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.animations.error),
                        Text(
                          "Failed to load cart",
                          style: context.typography.h3.copyWith(color: context.colors.primaryTxt),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.space.space_200),
                Padding(
                  padding: EdgeInsets.only(left: context.space.space_300),
                  child: Text(
                    "Available Coupons",
                    style: context.typography.bodyLarge.copyWith(color: const Color(0xff979797)),
                  ),
                ),
                SizedBox(height: context.space.space_100),

                // Coupon Input Section
                CouponInputSection(controller: controller),

                // Total Summary Section
                cartController.when(
                  data: (cart) => TotalAMountSectionWidget(
                    grandTotal: cart.totalPrice,
                    delivery: 0,
                    total: cart.totalPrice,
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
          padding: EdgeInsets.all(context.space.space_200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total: AED ${cart.totalPrice}',
                style: context.typography.bodyMedium,
              ),
              ButtonWidget(
                label: 'Proceed To Checkout',
                onTap: () {
                  // Navigate to checkout or display loading
                  ref.read(cartControllerProvider.notifier).clearCart();
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