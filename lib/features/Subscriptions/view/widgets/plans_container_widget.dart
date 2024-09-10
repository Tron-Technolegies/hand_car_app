import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plan_discount_widget.dart';

class PlansContainer extends StatelessWidget {
  final String planName;
  final String price;

  const PlansContainer({super.key, required this.planName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.all(context.space.space_250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            planName,
                            style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
                          ),
                           SizedBox(height: 10),
                           
                        RichText(
            text: TextSpan(
              text: 'AED $price ',
              style: context.typography.h2,
              children: [
                TextSpan(
                  text: '/month',
                  style: context.typography.bodyMedium.copyWith(color: context.colors.primaryTxt),)])),
                
                          const SizedBox(height: 20),
                          FeaturesCheckIconWidget(text: "Unlimited All Basic Wash Plan services"),
                          FeaturesCheckIconWidget(text: "Full interior shampoo"),
                          FeaturesCheckIconWidget(text: "Wax application"),
                          FeaturesCheckIconWidget(text: "Tire dressing"),
                          
                          const SizedBox(height: 20),
                          const Text(
                            'Multiple Cars Discount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PlanDiscountWidget(number: '1', plan: "Car Plan", price:"Full Price" ),
                          PlanDiscountWidget(number: '2', plan: "Car Plan", price:"10%off/car" ),
                          PlanDiscountWidget(number: '3', plan: "Car+ Plan", price:" 20%off/car" ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Subscribe'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              'Save 10% off on 6 months subscription',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     _buildDurationButton('6 Months', isSelected: true),
                          //     _buildDurationButton('12 Months', isSelected: false),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}