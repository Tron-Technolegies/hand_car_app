import 'package:hand_car/core/widgets/snack_bar_widget.dart';
import 'package:hand_car/main.dart';

class SnackbarUtil {
  /// show the message in the snackbar
  ///
  /// [message] is the message to be shown to the user
  static void showsnackbar({String message = "", bool showretry = false}) {
    final currentState = MainApp.scaffoldMessengerKey.currentState;
    if (currentState != null) {
      currentState.hideCurrentSnackBar();
      currentState.showSnackBar(Showsnackbar(
        errorMessage: message,
        showretry: showretry,
      ));
    }
  }
}
