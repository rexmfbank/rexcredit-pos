import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  required String body,
  required IconData icon,
  required Function()? onPressed,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 35),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: AppColors.rexPurpleLight)),
            SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
            SizedBox(height: 8),
            RexElevatedButton(
              onPressed: onPressed ?? () => context.pop(),
              buttonTitle: 'OK',
            ),
          ],
        ),
      );
    },
  );
}
