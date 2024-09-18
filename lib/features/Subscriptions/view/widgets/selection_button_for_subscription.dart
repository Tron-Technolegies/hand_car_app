import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class PlanButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final LinearGradient gradient;
  final Color textColor1;
  final Color textColor2;

  const PlanButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.gradient
    , required this.textColor1, required this.textColor2
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: context.space.space_200, vertical: context.space.space_100),
        decoration: BoxDecoration(
          gradient: isSelected?gradient
:null,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          label,
        
          style: context.typography.bodyMedium.copyWith(color: isSelected?textColor1:textColor2),
        ),
      ),
    );
  }
}