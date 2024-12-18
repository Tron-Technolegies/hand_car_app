

  import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

void showModernDialog(BuildContext context, String title, String message,
      String buttonText, Function() onTapDismiss, PanaraDialogType type) {
    PanaraInfoDialog.show(
      context,
      title: title,
      message: message,
      buttonText: buttonText,
      onTapDismiss: onTapDismiss,
      panaraDialogType: type,
    );
  }

