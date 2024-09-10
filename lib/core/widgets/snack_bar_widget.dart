import 'package:flutter/material.dart';
import 'package:hand_car/main.dart';

class Showsnackbar extends SnackBar {
  final String errorMessage;

  Showsnackbar({required this.errorMessage, bool showretry = false, super.key})
      : super(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(MainApp.scaffoldMessengerKey.currentContext!)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: const Color.fromARGB(255, 209, 209, 209)),
            ),
            duration: const Duration(milliseconds: 2500),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            action: (showretry)
                ? SnackBarAction(
                    label: "retry",
                    textColor: const Color.fromARGB(255, 189, 189, 189),
                    onPressed: () {})
                : null);
}
