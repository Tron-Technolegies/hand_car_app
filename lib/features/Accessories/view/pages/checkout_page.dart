import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/show_dialoge.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/address/address_controller.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/model/order_response/order_response.dart';
import 'package:hand_car/features/Accessories/view/widgets/address/address_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/address/address_form_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_summary_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final user = ref.watch(userProvider);
    final authController = ref.read(authControllerProvider.notifier);

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

    // Function to format address from AddressModel
    String formatAddress(dynamic address) {
      return '${address.street}, ${address.city}, ${address.state}, ZIP: ${address.zipCode}';
    }

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

    // Function to create WhatsApp message
    String createWhatsAppMessage(OrderResponse orderResponse) {
      final orderDetails = orderResponse.orderDetails;
      final items = (orderDetails['items'] as List<dynamic>)
          .map((item) =>
              '- ${item['name']} (Qty: ${item['quantity']}, Price: ${item['price']})')
          .join('\n');
      // Extract coupon details
      final coupon = orderDetails['coupon'] as Map<String, dynamic>?;
      String couponDetails = '';
      if (coupon != null) {
        couponDetails = '''
Coupon Applied:
- Name: ${coupon['name']}
- Code: ${coupon['coupon_code']}
- Discount: ${coupon['discount_percentage']}%''';
      }
      return '''
Order Confirmation
Order ID: ${orderResponse.orderId}
Name: ${orderDetails['name']}
phone: ${orderDetails['phone']}
Address: ${orderDetails['address']}
Total: ${orderDetails['total_price']}
Items:
$items
$couponDetails
Please confirm payment details.
''';
    }

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
                            style: context.typography.bodyLarge
                                .copyWith(color: Colors.red),
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
                          // TextButton.icon(
                          //   icon: const Icon(Icons.add),
                          //   label: const Text('Add New Address'),
                          //   onPressed: () => showAddressForm.value = true,
                          // ),
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
                            name: address.name,
                            phoneNumber: address.phoneNumber,
                            address: '${address.city}, ${address.areaDistrict}',
                            landmark: address.landmark ?? "",
                            selectedAddress: selectedAddress,
                            id: address.id,
                            isDefault: address.isDefault,
                            addressType: address.addressType,
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
                  onTap: () async {
                    // Check authentication
                    final isAuthenticated =
                        await authController.isAuthenticated();
                    if (!isAuthenticated || user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please login to place an order',
                            style: context.typography.bodyMedium
                                .copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      context.go('/login');
                      return;
                    }

                    // Validate address selection
                    if (selectedAddress.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please select a shipping address',
                            style: context.typography.bodyMedium
                                .copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Validate cart
                    final cart = cartController.valueOrNull;
                    if (cart == null || cart.cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Your cart is empty. Add items to proceed.',
                            style: context.typography.bodyMedium
                                .copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    try {
                      // Show loading indicator
                      LoadingOverlay.show(context);

                      // Find selected address
                      final selectedAddressModel = addressState.addresses
                          .firstWhere(
                              (address) => address.id == selectedAddress.value,
                              orElse: () => throw const CartException(
                                  'Selected address not found'));

                      // Format full address
                      final fullAddress = formatAddress(selectedAddressModel);

                      // Validate contact
                      final contact = user.phone.isNotEmpty == true
                          ? user.phone
                          : 'Unknown';
                      if (contact == 'Unknown') {
                        log('Warning: User phone is empty or null');
                      }

                      // Place order
                      final orderResponse = await ref
                          .read(cartControllerProvider.notifier)
                          .placeOrder(
                            addressId: selectedAddress.value!,
                            username: user.name,
                            contact: user.phone,
                            address: fullAddress,
                          );

                      // Hide loading indicator
                      LoadingOverlay.hide();

                      // Construct WhatsApp URL
                      final whatsappNumber =
                          '9895499872'; // Replace with your business number, e.g., '+1234567890'
                      final message = createWhatsAppMessage(orderResponse);
                      final encodedMessage = Uri.encodeComponent(message);
                      final whatsappUrl =
                          'https://wa.me/$whatsappNumber?text=$encodedMessage';

                      // Show success dialog with Make Payment button
                      showModernDialog(
                        context,
                        "Order Placed Successfully",
                        "Your order (ID: ${orderResponse.orderId}) has been successfully placed. Proceed to make payment via WhatsApp.",
                        "Make Payment",
                        () async {
                          final uri = Uri.parse(whatsappUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Unable to open WhatsApp',
                                  style: context.typography.bodyMedium
                                      .copyWith(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          context.go(NavigationPage.route);
                        },
                        PanaraDialogType.success,
                      );
                    } catch (e) {
                      // Hide loading indicator on error
                      LoadingOverlay.hide();

                      log('Error placing order: $e');
                      String errorMessage = 'Failed to place order';
                      if (e is CartException) {
                        errorMessage = e.message;
                        if (errorMessage.contains('Cart is empty')) {
                          errorMessage =
                              'Your cart is empty. Add items to proceed.';
                        } else if (errorMessage
                            .contains('Insufficient stock')) {
                          errorMessage =
                              'Some items are out of stock. Please review your cart.';
                        } else if (errorMessage.contains('Please login')) {
                          errorMessage = 'Please login to place an order';
                          context.go('/login');
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorMessage,
                            style: context.typography.bodyMedium
                                .copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
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

// Updated LoadingOverlay class
class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(0.3),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
