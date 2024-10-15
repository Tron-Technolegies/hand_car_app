import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

// Services Button for Service Page
class ServicesButtonWidget extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final Function(int) onSelectPlan;
  final bool isSelected;

  const ServicesButtonWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.selectedIndex,
    required this.onSelectPlan,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isSelected ? context.colors.primaryTxt : context.colors.background,
        ),
      ),
      onPressed: () => onSelectPlan(selectedIndex),
      child: Text(
        title,
        style: context.typography.bodyLargeMedium.copyWith(
          color: isSelected ? context.colors.white : const Color(0xff767676),
        ),
      ),
    );
  }
}
