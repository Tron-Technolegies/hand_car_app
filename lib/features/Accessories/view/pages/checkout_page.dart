import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/show_dialoge.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
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
    final isRefreshing = useState(false);
    
    final cartController = ref.watch(cartControllerProvider);
    final addressState = ref.watch(addressControllerProvider);
    final addressController = ref.read(addressControllerProvider.notifier);

    // Set default address as selected when addresses are loaded
    useEffect(() {
      if (selectedAddress.value == null && addressState.addresses.isNotEmpty) {
        final defaultAddress = addressState.addresses.firstWhere(
          (address) => address.isDefault,
          orElse: () => addressState.addresses.first,
        );
        selectedAddress.value = defaultAddress.id;
      }
      return null;
    }, [addressState.addresses]);

    // Function to handle refresh
    Future<void> refreshAddresses() async {
      log('Starting address refresh...');
      isRefreshing.value = true;
      try {
        await addressController.fetchAddresses();
        log('Address fetch completed successfully');
      } catch (e) {
        log('Error fetching addresses: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error refreshing addresses: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        isRefreshing.value = false;
      }
    }

    // Initialize address fetch
    useEffect(() {
      Future.microtask(() => refreshAddresses());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: context.typography.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (isRefreshing.value)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: refreshAddresses,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshAddresses,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(context.space.space_200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Summary Section
              cartController.when(
                data: (cart) => CartSummaryWidget(cart: cart),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('Error loading cart: $error'),
              ),
              
              SizedBox(height: context.space.space_200),
              Text(
                'Select a shipping address',
                style: context.typography.h3,
              ),
              SizedBox(height: context.space.space_200),
              
              // Address List Section
              Builder(
                builder: (context) {
                  if (addressState.isLoading || isRefreshing.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (addressState.error != null) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            'Error: ${addressState.error}',
                            style: context.typography.bodyLarge.copyWith(color: Colors.red),
                          ),
                          TextButton(
                            onPressed: refreshAddresses,
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  if (addressState.addresses.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            'No addresses found',
                            style: context.typography.bodyLarge,
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Add New Address'),
                            onPressed: () => showAddressForm.value = true,
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: addressState.addresses.length,
                        separatorBuilder: (_, __) => 
                            SizedBox(height: context.space.space_200),
                        itemBuilder: (context, index) {
                          final address = addressState.addresses[index];
                          return AddressCard(
                            key: ValueKey(address.id),
                            name: address.street,
                            address: '${address.city}, ${address.state}',
                            poBox: 'ZIP: ${address.zipCode}',
                            selectedAddress: selectedAddress,
                            id: address.id,
                            isDefault: address.isDefault,
                          );
                        },
                      ),
                      SizedBox(height: context.space.space_300),
                    ],
                  );
                },
              ),
              
              // Add Address Button
              TextButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () => showAddressForm.value = !showAddressForm.value,
                label: Text(
                  showAddressForm.value ? 'Hide form' : 'Add new address',
                  style: context.typography.bodyLarge,
                ),
              ),
              
              // Address Form
              if (showAddressForm.value) ...[
                SizedBox(height: context.space.space_200),
                AddressForm(
                  onAddressAdded: () async {
                    showAddressForm.value = false;
                    await Future.delayed(const Duration(milliseconds: 500));
                    await refreshAddresses();
                  },
                ),
                SizedBox(height: context.space.space_200),
              ],
              
              // Place Order Button
              SizedBox(height: context.space.space_200),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  label: "Place Order",
                  onTap: () {
                    if (selectedAddress.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please select a shipping address',
                            style: context.typography.bodyMedium.copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    
                    showModernDialog(
                      context,
                      "Order Placed",
                      "Your order has been placed successfully",
                      "OK",
                      () => context.go(NavigationPage.route),
                      PanaraDialogType.success,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}