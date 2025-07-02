import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

showCustomErrorDialog({
  required BuildContext context,
  required String? errorText,
  String? title,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return RexErrorDialog(
        title: title,
        errorText: errorText,
      );
    },
  );
}

class RexErrorDialog extends StatelessWidget {
  const RexErrorDialog({
    super.key,
    this.errorText,
    this.title,
  });

  final String? errorText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: ErrorTitleText(title: title),
        actions: [
          ErrorDismissButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: ErrorContent(errorText: errorText),
      );
    }
    return AlertDialog(
      title: ErrorTitleText(title: title),
      actions: [
        ErrorDismissButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: ErrorContent(errorText: errorText),
    );
  }
}

class ErrorTitleText extends StatelessWidget {
  final String? title;
  const ErrorTitleText({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title ?? 'An error occurred');
  }
}

class ErrorDismissButton extends StatelessWidget {
  const ErrorDismissButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Dismiss',
        style: TextStyle(
          color: AppColors.rexPurpleDark,
        ),
      ),
    );
  }
}

class ErrorContent extends StatelessWidget {
  const ErrorContent({
    super.key,
    this.errorText,
  });

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: errorText != null
              ? Text(errorText ?? "Unknown error")
              : Container(),
        ),
      ],
    );
  }
}
