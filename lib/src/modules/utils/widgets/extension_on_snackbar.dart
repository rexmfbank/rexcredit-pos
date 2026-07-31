import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

/// How long every snackbar stays on screen unless a call passes its own
/// duration.
const kSnackDuration = Duration(seconds: 3);

extension GlobalScaffoldSnack on GlobalKey<ScaffoldMessengerState> {
  void showSnack({
    required String message,
    Duration duration = kSnackDuration,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    final messengerState = currentState;
    if (messengerState == null) return;
    messengerState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontSize: 14.asp),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(messengerState.context).size.height * 0.4,
          left: 50,
          right: 50,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

extension ScaffoldStateExtension on BuildContext {
  void showSnack({
    required String message,
    Duration duration = kSnackDuration,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontSize: 14.asp),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(this).size.height * 0.4,
          left: 50,
          right: 50,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void showSnackBar({
    required String message,
    Duration duration = kSnackDuration,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    String actionLabel = 'OK',
    Function? onActionPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
      duration: duration,
      action:
          onActionPressed != null
              ? SnackBarAction(
                label: actionLabel,
                onPressed: () {
                  onActionPressed();
                },
              )
              : null,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showErrorSnackBar({
    required String message,
    Duration duration = kSnackDuration,
    Color backgroundColor = AppColors.rexError,
    Color textColor = Colors.white,
    String actionLabel = 'OK',
    Function? onActionPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
      duration: duration,
      action:
          onActionPressed != null
              ? SnackBarAction(
                label: actionLabel,
                onPressed: () {
                  onActionPressed();
                },
              )
              : null,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSuccessSnackBar({
    required String message,
    Duration duration = kSnackDuration,
    Color backgroundColor = AppColors.rexGreen,
    Color textColor = Colors.white,
    String actionLabel = 'OK',
    Function? onActionPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
      duration: duration,
      action:
          onActionPressed != null
              ? SnackBarAction(
                label: actionLabel,
                onPressed: () {
                  onActionPressed();
                },
              )
              : null,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
