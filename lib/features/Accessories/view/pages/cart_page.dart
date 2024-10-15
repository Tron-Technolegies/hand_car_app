import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart_summary_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/address_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/address_form_widget.dart';

//Cart Page
class CheckOutPage extends HookWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hooks for showing and hiding address form
    final showAddressForm = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: context.typography.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CartSummaryWidget(),
            Text(
              'Select a shipping address',
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_200),
             const AddressCard(
              name: 'Ahmed Al-Farsi',
              address:
                  '123 Sheikh Zayed Road, Downtown Dubai, Dubai,\nUnited Arab Emirates',
              poBox: 'P.O. Box 12345',
              mobile: 'Mobile: +971 50 123 4567',
              
            ),
            SizedBox(height: context.space.space_200),
             const AddressCard(
              name: 'Ahmed Al-Farsi',
              address:
                  '123 Sheikh Zayed Road, Downtown Dubai, Dubai,\nUnited Arab Emirates',
              poBox: 'P.O. Box 12345',
              mobile: 'Mobile: +971 50 123 4567',
              
            ),
            SizedBox(height: context.space.space_300),
            TextButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () {
                showAddressForm.value = !showAddressForm.value;
              },
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
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
