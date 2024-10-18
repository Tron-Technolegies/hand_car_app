import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class CartItem {
  final String name;
  final String modelNumber;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.modelNumber,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class ShoppingCartScreen extends HookWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final couponController = useTextEditingController();

    final cartItems = useState<List<CartItem>>(
      List.generate(
        8,
        (index) => CartItem(
          name: 'Dash Cam 4K A800S Native True 4K Resolution (Front Only)',
          modelNumber: 'A800S',
          price: 370.00,
          imageUrl: Assets.images.imgCarCareAccessories.path,
        ),
      ),
    );

    final total = useMemoized(
      () => cartItems.value.fold(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      ),
      [cartItems.value],
    );

    const delivery = 20.00;
    final grandTotal = total + delivery;

    void updateQuantity(int index, int newQuantity) {
      final newList = List<CartItem>.from(cartItems.value);
      newList[index].quantity = newQuantity;
      cartItems.value = newList;
    }

    void removeItem(int index) {
      final newList = List<CartItem>.from(cartItems.value);
      newList.removeAt(index);
      cartItems.value = newList;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Breadcrumb

              // Cart Items List
              ListView.builder(
                itemCount: cartItems.value.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartItemWidget(
                    item: cartItems.value[index],
                    onQuantityChanged: (qty) => updateQuantity(index, qty),
                    onRemove: () => removeItem(index),
                  );
                },
              ),

              // Coupon Cards
              CouponCardsSection(),

              // Coupon Input
              CouponInputSection(controller: couponController),

              // Total Summary
              TotalSummarySection(
                total: total,
                delivery: delivery,
                grandTotal: grandTotal,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: cartItems.value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Grand Total: AED $grandTotal',
                      style: context.typography.bodyMedium),
                  ButtonWidget(label: 'Proceed To Pay', onTap: () {})
                ],
              ),
            )
          : null,
    );
  }
}

class CartItemWidget extends HookWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = useState(item.quantity);

    useEffect(() {
      if (quantity.value != item.quantity) {
        onQuantityChanged(quantity.value);
      }
      return null;
    }, [quantity.value]);

    return Card(
      color: context.colors.background,
      child: Container(
        padding: EdgeInsets.all(context.space.space_200),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                children: [
                  Text(
                    item.name,
                    style: context.typography.bodyMedium,
                  ),
                  Text(
                    'Model Number: ${item.modelNumber}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Quantity Dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<int>(
                value: quantity.value,
                underline: SizedBox(),
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) quantity.value = value;
                },
              ),
            ),
            SizedBox(width: 16),

            // Price
            Text(
              'AED ${(item.price * quantity.value).toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green),
            ),

            // Remove Button
            IconButton(
              icon: Icon(Icons.close),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class CouponCardsSection extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (context, index) => CouponCard(),
        ),
      ),
    );
  }
}

class CouponCard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isCopied = useState(false);

    return Container(
      width: 400,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5% OFF',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('FOR WHOLE ORDER'),
          SizedBox(height: 8),
          Row(
            children: [
              Text('Code: NEWCUSTOMER_1234'),
              Spacer(),
              TextButton(
                onPressed: () {
                  isCopied.value = true;
                  // Add actual copy functionality here
                },
                child: Text(isCopied.value ? 'Copied!' : 'Copy'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CouponInputSection extends HookWidget {
  final TextEditingController controller;

  const CouponInputSection({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Do you have any Coupon code ?'),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Your code here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('APPLY'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TotalSummarySection extends HookWidget {
  final double total;
  final double delivery;
  final double grandTotal;

  const TotalSummarySection({
    Key? key,
    required this.total,
    required this.delivery,
    required this.grandTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Text('AED ${total.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery'),
              Text('AED ${delivery.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand total'),
              Text(
                'AED ${grandTotal.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('CHECKOUT'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          minimumSize: Size(double.infinity, 48),
        ),
      ),
    );
  }
}
