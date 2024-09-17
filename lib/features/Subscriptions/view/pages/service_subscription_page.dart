import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/button_for%20plan_selection_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class ServicePlanScreen extends HookConsumerWidget {
  static const String route = '/servicePlans';
  const ServicePlanScreen({super.key});


  @override
  /// Returns a Scaffold with a gradient background and a single child: a
  /// SingleChildScrollView with a Column of children.
  ///
  /// The Column contains a Text widget with a title, a Text widget with a
  /// description, a SizedBox with a height of 20, a Row with a PlanSelectionButtons
  /// widget in the center, a SizedBox with a height of 20, and a PageView with
  /// a height of 500.
  ///
  /// The PageView contains 3 children: 3 PlansContainer widgets with different
  /// plan names, prices, and features.
  ///
  /// The PageView is wrapped in a SizedBox with a height of 500 to avoid layout
  /// issues.
  ///
  /// The PageView's onPageChanged callback is set to update the selectedIndex
  /// state when the page changes.
  Widget build(BuildContext context, ref) {
    final selectedIndex = useState(0);
    final pageController=usePageController();
    //Page changing function
    void onItemTapped(int index) {
      selectedIndex.value = index;
      pageController.jumpToPage(index);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
           
          ),
          child: SafeArea(
            child: Column(
              children: [
                 const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Plans for Maintainance Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Explore our subscription plans for additional \nservices and keep your car looking its best year-round.\n Enjoy exclusive benefits and regular\n maintenance with our comprehensive packages.',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlanSelectionButtons(
                      selectedIndex: selectedIndex.value,
                      onSelectPlan: onItemTapped,
                      gradientColor:  const LinearGradient(
                       
                        colors: [
                          Color(0xff000000),
                          Color(0xff787878),
                      
                        ],
                      ),
                      textColor1: Colors.white,
                      textColor2: const Color(0xff787878),
                      containerColor: context.colors.background,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // PageView For Plans
                SizedBox(
                  height: 500,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (index) => selectedIndex.value = index,
                    children:  [
                      PlansContainer(
                        planName: 'Basic',
                        price: '299',
                        planFeature1:
                            "Unlimited synthetic oil changes",
                        planFeature2: "Seasonal tire rotations",
                        planFeature3: "Priority scheduling",
                        color: context.colors.primaryTxt,
                        containerColor: context.colors.background,
                        textColor1: context.colors.primaryTxt,
                        textColor2: const Color(0xff787878),
                      ),
                      PlansContainer(
                        planName: 'Premium',
                        price: '599',
                        planFeature1: "All Basic Maintenance Plan services",
                        planFeature2: "Brake pad replacements",
                        planFeature3: "Battery check and replacement",
                        planFeature4: "Fluid top-offs",
                        color: context.colors.primaryTxt,
                        containerColor: context.colors.background,
                        textColor1: context.colors.primaryTxt,
                        textColor2: const Color(0xff787878),

                      ),
                      PlansContainer(
                        planName: "Luxury ",
                        price: "749",
                        planFeature1:
                            "All Premium Maintenance Plan services",
                        planFeature2: "Monthly diagnostics",
                        planFeature3: "24/7 roadside assistance",
                        planFeature4:"Complimentary detailing twice a year",
                        color: context.colors.primaryTxt,
                        containerColor: context.colors.background,
                        textColor1: context.colors.primaryTxt,
                        textColor2: const Color(0xff787878),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}