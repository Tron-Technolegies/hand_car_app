// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/selection_button_for_subscription.dart';

class PlanSelectionButtons extends StatelessWidget {
  final List<String> plans = ['Basic', 'Premium', 'Luxury'];
  final int selectedIndex;
  final Function(int) onSelectPlan;
  final LinearGradient gradientColor;
  final Color textColor1;
  final Color textColor2;
  final Color containerColor;

   PlanSelectionButtons({
    super.key,
    required this.selectedIndex,
    required this.onSelectPlan,
    required this.gradientColor
    , required this.textColor1, required this.textColor2, required this.containerColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          plans.length,
          (index) => PlanButton(
            gradient: gradientColor,
            label: plans[index],
            isSelected: index == selectedIndex,
            onTap: () => onSelectPlan(index),
            textColor1: textColor1,
            textColor2: textColor2,
          ),
        ),
      ),
    );
  }

}