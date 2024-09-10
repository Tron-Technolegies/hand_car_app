import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/button_for%20plan_selection_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/check_icon_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarWashPlanScreen extends HookConsumerWidget {
  
  const CarWashPlanScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final selectedIndex=useState(0);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffD50104),
              Color(0xffffffff),
              Color(0xffffffff),
            ]
          )
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
                PlanSelectionButtons(selectedIndex: selectedIndex.value, onSelectPlan: (index) => selectedIndex.value = index),
                ],
              ),
              const SizedBox(height: 20),
              PlansContainer(planName: 'Basic Wash', price: '400')
            ],
          ),
        ),
      ),
    );
  }

  

}


//   Widget _buildDurationButton(String text, {required bool isSelected}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 5),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Text(text),
//         style: ElevatedButton.styleFrom(
//           foregroundColor: isSelected ? Colors.white : Colors.red, 
//           side: const BorderSide(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }


