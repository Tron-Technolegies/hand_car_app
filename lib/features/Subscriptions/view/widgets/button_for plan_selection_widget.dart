// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/selection_button_for_subscription.dart';

class PlanSelectionButtons extends StatelessWidget {
  final List<String> plans = ['Basic', 'Premium', 'Luxury'];
  final int selectedIndex;
  final Function(int) onSelectPlan;

   PlanSelectionButtons({
    super.key,
    required this.selectedIndex,
    required this.onSelectPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 225, 225),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          plans.length,
          (index) => PlanButton(
            label: plans[index],
            isSelected: index == selectedIndex,
            onTap: () => onSelectPlan(index),
          ),
        ),
      ),
    );
  }

}