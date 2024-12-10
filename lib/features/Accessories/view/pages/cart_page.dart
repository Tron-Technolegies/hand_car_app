import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_product_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/total_amount_section_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_card_listview_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_input_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

// c
import 'package:hand_car/features/Accessories/controller/coupon/coupon_controller.dart';

class ShoppingCartScreen extends HookConsumerWidget {
  static const route = '/cart_page';
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartControllerProvider);
    final couponController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shopping Cart', style: context.typography.h3),
        actions: [
          if (cartController.asData?.value.cartItems.isNotEmpty ?? false)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {},
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
                cartController.when(
                  data: (cart) {
                    if (cart.cartItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(Assets.animations.emptyCart,
                                repeat: false),
                            SizedBox(height: context.space.space_100),
                            Text(
                              "Your cart is empty",
                              style: context.typography.h3.copyWith(
                                color: context.colors.primaryTxt,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.cartItems.length,
                      separatorBuilder: (_, __) => SizedBox(
                        height: context.space.space_100,
                      ),
                      itemBuilder: (context, index) {
                        final item = cart.cartItems[index];
                        return ProductCard(
                          productName: item.productName,
                          price: item.productPrice,
                          quantity: item.quantity,
                          image:
                              'https://e7.pngegg.com/pngimages/809/777/png-clipart-car-revathy-auto-parts-ford-motor-company-spare-part-advance-auto-parts-car-car-vehicle-thumbnail.png',
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: Lottie.asset(Assets.animations.loading),
                  ),
                  error: (error, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.animations.error, height: 150),
                        SizedBox(height: context.space.space_100),
                        Text(
                          "Failed to load cart: $error",
                          style: context.typography.h3.copyWith(
                            color: context.colors.primaryTxt,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                if (cartController.asData?.value.cartItems.isNotEmpty ?? false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.space.space_200),
                      CouponCardListView(
                        onCouponApply: (coupon) {
                          couponController.text = coupon.couponCode;
                          ref
                              .read(cartControllerProvider.notifier)
                              .applyCoupon(coupon);
                        },
                      ),
                      CouponInputSection(
                        controller: couponController,
                        onApply: (code) {
                          final validCoupon = ref
                              .read(couponControllerProvider)
                              .asData
                              ?.value
                              .where((coupon) => coupon.couponCode == code)
                              .firstOrNull;
                          if (validCoupon != null) {
                            ref
                                .read(cartControllerProvider.notifier)
                                .applyCoupon(validCoupon);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid Coupon Code!'),
                              ),
                            );
                          }
                        },
                      ),
                      Consumer(
                        builder: (_, ref, __) {
                          final cart = ref.watch(cartControllerProvider).value;
                          return TotalAmountSectionWidget(
                            grandTotal: cart!.discountedTotal,
                            delivery: 0,
                            total: cart.discountedTotal,
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          cartController.asData?.value.cartItems.isNotEmpty ?? false
              ? Padding(
                  padding: EdgeInsets.all(context.space.space_200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (_, ref, __) {
                          /// Cart Total
                          final cart = ref.watch(cartControllerProvider).value;
                          //
                          return Text(
                            'Total: AED ${cart!.discountedTotal.toStringAsFixed(2)}',
                            style: context.typography.bodyMedium,
                          );
                        },
                      ),
                      ButtonWidget(
                        label: 'Proceed To Checkout',
                        onTap: () => context.push(CheckOutPage.route),
                      ),
                    ],
                  ),
                )
              : null,
    );
  }
}
