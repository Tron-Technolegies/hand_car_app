import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/button_for%20plan_selection_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class CarWashPlanScreen extends HookConsumerWidget {
  const CarWashPlanScreen({super.key});

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
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffD50104),
                Color(0xffffffff),
                Color(0xffffffff),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'A Plan for Every Car\nWashing Need',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Whether it\'s a quick rinse or a detailed clean, we offer customized services to meet every car washing need. Experience the difference with our specialized care and attention to detail.',
                    style: TextStyle(color: Colors.white),
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
                    children: const [
                      PlansContainer(
                        planName: 'Basic',
                        price: '299',
                        planFeature1:
                            "Unlimited Exterior wash using high-pressure sprays Interior vacuuming",
                        planFeature2: "Cleaning of windows and mirrors",
                      ),
                      PlansContainer(
                        planName: 'Premium',
                        price: '599',
                        planFeature1: "Unlimited All Basic Wash Plan services",
                        planFeature2: "Full interior shampoo",
                        planFeature3: "Wax application",
                        planFeature4: "Tire dressing",
                      ),
                      PlansContainer(
                        planName: "Luxury ",
                        price: "749",
                        planFeature1:
                            "Unlimited All Premium Wash Plan services",
                        planFeature2: "Engine compartment wash",
                        planFeature3: "High-definition waxing",
                        planFeature4: "Leather conditioning",
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