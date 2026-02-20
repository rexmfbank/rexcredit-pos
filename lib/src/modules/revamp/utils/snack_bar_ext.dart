import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

extension ScaffoldStateExtension on BuildContext {
  void showSnack({
    required String message,
    Duration duration = const Duration(milliseconds: 700),
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

  void showToastUpdatingProcess(String message) {
    showToast(message: message);
  }

  void showToastForSettingsFalse() {
    showToast(message: "Please download settings");
  }

  void showToastForSettingsDone() {
    showToast(message: "Download settings completed");
  }

  void showToastForSettingsFailed() {
    showToast(message: "Download Settings failed, try again");
  }

  void showToastForNoBaseApp() {
    showToast(message: "Failed, cannot detect Base App");
  }

  void showToastForAuthFailedII() {
    showToast(message: "Identification failed. Please download settings");
  }

  void showToast({
    required String message,
    Toast? toastLength,
    ToastGravity? gravity,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: textColor,
      fontSize: 14.asp,
      backgroundColor: backgroundColor,
    );
  }

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
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
    Duration duration = const Duration(seconds: 2),
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
    Duration duration = const Duration(seconds: 2),
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
