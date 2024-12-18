// Cart Page
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/show_dialoge.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/address/address_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/address/address_form_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_summary_widget.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class CheckOutPage extends HookConsumerWidget {
  static const route = '/checkout-page';

  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAddressForm = useState(false);
    final selectedAddress = useState<String?>(null);
    final cartController = ref.watch(cartControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: context.typography.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cartController.when(
              data: (cart) => CartSummaryWidget(cart: cart),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error loading cart: $error'),
            ),
            Text(
              'Select a shipping address',
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_200),
            AddressCard(
              name: 'Muhammed Risan',
              address:
                  '123 Sheikh Zayed Road, Downtown Dubai, Dubai,\nUnited Arab Emirates',
              poBox: 'P.O. Box 12345',
              mobile: 'Mobile: +971 50 123 4567',
              selectedAddress: selectedAddress,
            ),
            SizedBox(height: context.space.space_200),
            AddressCard(
              name: 'Kollam Shafi',
              address:
                  '123 Sheikh Zayed Road, Downtown Dubai, Dubai,\nUnited Arab Emirates',
              poBox: 'P.O. Box 12345',
              mobile: 'Mobile: +971 50 123 4567',
              selectedAddress: selectedAddress,
            ),
            SizedBox(height: context.space.space_300),
            TextButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () => showAddressForm.value = !showAddressForm.value,
              label: Text(
                'Add new address',
                style: context.typography.bodyLarge,
              ),
            ),
            if (showAddressForm.value) ...[
              SizedBox(height: context.space.space_200),
              const AddressForm(),
              SizedBox(height: context.space.space_200),
            ],
            SizedBox(height: context.space.space_200),
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                label:
                    showAddressForm.value ? "Add & Choose Address" : "Continue",
                onTap: () => {
                  showModernDialog(context, "Order Placed",
                      "Your order has been placed successfully", "OK", () => context.go(NavigationPage.route), PanaraDialogType.success)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
