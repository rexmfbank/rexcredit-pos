import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

showRexErrorDialog({
  required BuildContext context,
  required String? errorText,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return RexErrorDialog(
        errorText: errorText,
      );
    },
  );
}

class RexErrorDialog extends StatelessWidget {
  const RexErrorDialog({
    super.key,
    this.errorText,
  });

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const ErrorTitleText(),
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
      title: const ErrorTitleText(),
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
  const ErrorTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('An error occurred');
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
      child: const Text(
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
        const Flexible(
          child: Text('This process had an error.'),
        ),
        Flexible(
          child: errorText != null ? Text("$errorText") : Container(),
        ),
      ],
    );
  }
}
