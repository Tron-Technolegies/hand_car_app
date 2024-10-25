import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart_product_card_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon_card_listview_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/coupon_input_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/total_amount_section_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class ShoppingCartScreen extends HookWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(' Cart', style: context.typography.h3),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.space.space_200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb

                  // Cart Items List
                  ListView.builder(
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        productName:
                            "4K Dash Cam 4K A800S Native True 4K Resolution (Front Only)",
                        modelNumber: 'A800S',
                        image: Assets.images.imgCarCareAccessories.path,
                        price: 599,
                      );
                    },
                  ),
                  SizedBox(height: context.space.space_200),
                  Padding(
                    padding: EdgeInsets.only(left: context.space.space_300),
                    child: Text("Available Coupons",
                        style: context.typography.bodyLarge
                            .copyWith(color: const Color(0xff979797))),
                  ),

                  SizedBox(height: context.space.space_100),
                  // Coupon Cards
                  const CouponCardListView(),

                  // Coupon Input
                  // CouponInputSection(controller: couponController),

                  // Total Summary

                  SizedBox(height: context.space.space_100),
                  CouponInputSection(controller: controller),
                  const TotalAMountSectionWidget(
                    total: 2240,
                    delivery: 50,
                    grandTotal: 2290,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Grand Total: AED 2290',
                  style: context.typography.bodyMedium),
              ButtonWidget(
                  label: 'Proceed To Pay',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CheckOutPage();
                    }));
                  })
            ],
          ),
        ));
  }
}

// Quantity Button Widget






