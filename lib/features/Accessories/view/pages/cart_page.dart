import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/total_amount_section_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class ShoppingCartScreen extends HookConsumerWidget {
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
              onPressed: (){},
              // onPressed: () => cartNotifier.,
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: cartController.when(
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
                      itemCount: cart.cartItems.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = cart.cartItems[index];
                        return ListTile(
                          title: Text(
                            item.productName,
                            style: context.typography.bodyLarge,
                          ),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing: Text(
                            'AED ${item.totalPrice}',
                            style: context.typography.bodyMedium,
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
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
              ),
              if (cartController.asData?.value.cartItems.isNotEmpty ?? false) ...[
                const SizedBox(height: 20),
                TotalAmountSectionWidget(
                  grandTotal: cartController.asData!.value.totalAmount,
                  delivery: 0,
                  total: cartController.asData!.value.totalAmount,
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: cartController.asData?.value.cartItems.isNotEmpty ?? false
          ? Padding(
              padding: EdgeInsets.all(context.space.space_200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: AED ${cartController.asData!.value.totalAmount.toStringAsFixed(2)}',
                    style: context.typography.bodyMedium,
                  ),
                  ButtonWidget(
                    label: 'Proceed To Checkout',
                    onTap: () => context.go('/checkout'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}