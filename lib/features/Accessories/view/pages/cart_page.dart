import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_product_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/total_amount_section_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_card_listview_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon/coupon_input_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:hand_car/features/Accessories/controller/coupon/coupon_controller.dart';

class ShoppingCartScreen extends HookConsumerWidget {
  static const route = '/cart_page';
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Store ScaffoldMessengerState to avoid context issues
    final scaffoldMessenger = useMemoized(() => ScaffoldMessenger.of(context));
    // Create TextEditingController with explicit disposal
    final couponController = useState(TextEditingController());
    final cartController = ref.watch(cartControllerProvider);

    // Dispose controller manually
    useEffect(() {
      return () => couponController.value.dispose();
    }, []);

    // Global error listener for cart errors
    ref.listen<AsyncValue<CartModel>>(cartControllerProvider, (previous, next) {
      next.when(
        data: (_) {},
        loading: () {},
        error: (error, _) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Cart error: $error'),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shopping Cart', style: context.typography.h3),
        actions: [
          if (cartController.asData?.value.cartItems.isNotEmpty ?? false)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text('Are you sure you want to clear your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // ref.read(cartControllerProvider.notifier).clearCart();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
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
                cartController.when(
                  data: (cart) {
                    if (cart.cartItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(Assets.animations.emptyCart, repeat: false),
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
                      separatorBuilder: (_, __) => SizedBox(height: context.space.space_100),
                      itemBuilder: (context, index) {
                        final item = cart.cartItems[index];
                        return ProductCard(
                          key: ValueKey(item.id.toString()),
                          currentQuantity: item.quantity,
                          cartItemId: item.id,
                          productName: item.productName,
                          price: item.productPrice,
                          image: item.productImage,
                          onDelete: () async {
                            try {
                              await ref.read(cartControllerProvider.notifier).removeFromCart(item.id);
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: const Text('Item removed successfully'),
                                  behavior: SnackBarBehavior.fixed,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            } catch (e) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Error removing item: $e'),
                                  behavior: SnackBarBehavior.fixed,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          onQuantityChanged: (newQuantity) async {
                            try {
                              await ref.read(cartControllerProvider.notifier).updateQuantity(item.id, newQuantity);
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: const Text('Quantity updated'),
                                  behavior: SnackBarBehavior.fixed,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            } catch (e) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Error updating quantity: $e'),
                                  behavior: SnackBarBehavior.fixed,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.animations.error, height: 150),
                        SizedBox(height: context.space.space_100),
                        Text(
                          error.toString(),
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
                          couponController.value.text = coupon.couponCode;
                          ref.read(cartControllerProvider.notifier).applyCoupon(coupon);
                        },
                      ),
                      CouponInputSection(
                        controller: couponController.value,
                        onApply: (code) {
                          final validCoupon = ref
                              .read(couponControllerProvider)
                              .asData
                              ?.value
                              .where((coupon) => coupon.couponCode == code)
                              .firstOrNull;
                          if (validCoupon != null) {
                            ref.read(cartControllerProvider.notifier).applyCoupon(validCoupon);
                            scaffoldMessenger.showSnackBar(
                              SnackBar(
                                content: const Text('Coupon applied successfully!'),
                                behavior: SnackBarBehavior.fixed,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          } else {
                            scaffoldMessenger.showSnackBar(
                              SnackBar(
                                content: const Text('Invalid Coupon Code!'),
                                behavior: SnackBarBehavior.fixed,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                      ),
                      Consumer(
                        builder: (_, ref, __) {
                          final cart = ref.watch(cartControllerProvider).value;
                          if (cart == null) return const SizedBox.shrink();
                          return TotalAmountSectionWidget(
                            grandTotal: cart.discountedTotal,
                            delivery: 0,
                            total: cart.totalAmount,
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
      bottomNavigationBar: cartController.asData?.value.cartItems.isNotEmpty ?? false
          ? Padding(
              padding: EdgeInsets.all(context.space.space_200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer(
                    builder: (_, ref, __) {
                      final cart = ref.watch(cartControllerProvider).value;
                      if (cart == null) return const SizedBox.shrink();
                      return Text(
                        'Total: AED ${cart.discountedTotal.toStringAsFixed(2)}',
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