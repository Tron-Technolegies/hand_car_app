import 'package:flutter/material.dart';
import 'package:hand_car/main.dart';

class CustomToast {
  static void show(String message, {bool isError = false}) {
    final messenger = MainApp.scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade500,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: _calculateBottomMargin(),
          left: 10.0,
          right: 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 6.0,
        duration: const Duration(milliseconds: 2500),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      ),
    );
  }

  static double _calculateBottomMargin() {
    final context = MainApp.scaffoldMessengerKey.currentContext;
    if (context == null) return 140.0;

    final media = MediaQuery.of(context);
    final bottomInset = media.padding.bottom;
    const bottomBarHeight = 104.0; // Adjusted for DockingBar + padding
    const extraSpacing = 30.0;

    return bottomBarHeight + bottomInset + extraSpacing;
  }

  static void showSuccess(String message) => show(message, isError: false);
  static void showError(String message) => show(message, isError: true);
}