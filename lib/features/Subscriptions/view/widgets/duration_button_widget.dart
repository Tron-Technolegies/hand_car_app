// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/duration_selection_button.dart';

class DurationButtons extends StatelessWidget {
  final List<String> duration = ['6 Months', '12 Months', ];
  final int selectedIndex;
  final Function(int) onSelectPlan;
  final Color containerColor;
  final Color textColor1;
  final Color textColor2;

   DurationButtons({
    super.key,
    required this.selectedIndex,
    required this.onSelectPlan,
    required this.containerColor
    , required this.textColor1, required this.textColor2
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(25),
      ),
      padding:  EdgeInsets.all(context.space.space_50),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          duration.length,
          (index) => DurationSelectionButton(
            label: duration[index],
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