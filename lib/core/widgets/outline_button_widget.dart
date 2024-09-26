import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class OutlineButtonWidget extends StatelessWidget {
  final bool isDanger;
  final String label;
  final bool isLoading;

  /// Callback to execute when the button is clicked
  final VoidCallback onTap;

  const OutlineButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  }) : isDanger = false;

  const OutlineButtonWidget.danger({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  }) : isDanger = true;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = context.colors.white;
    final textColor = context.colors.primaryTxt;

    if (isDanger) {
      backgroundColor = context.colors.warning;
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        foregroundColor: WidgetStatePropertyAll(textColor),
        side: WidgetStatePropertyAll(
            BorderSide(color: context.colors.primaryTxt)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.space.space_100),
          ),
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: context.colors.backgroundSubtle,
            )
          : Text(
              label,
              style: context.typography.bodyLarge
                  .copyWith(color: context.colors.primaryTxt),
            ),
    );
  }
}
