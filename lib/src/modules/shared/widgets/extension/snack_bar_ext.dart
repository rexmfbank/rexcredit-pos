import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

extension ScaffoldStateExtension on BuildContext {
  void showToast({
    required String message,
    Toast? toastLength,
    ToastGravity? gravity,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
}){
    Fluttertoast.showToast(
        msg: message,
        toastLength:toastLength ?? Toast.LENGTH_SHORT,
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
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: onActionPressed != null
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
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: onActionPressed != null
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
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: onActionPressed != null
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