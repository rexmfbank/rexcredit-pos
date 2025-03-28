import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

void modalDialogPinChange({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return ModalDialogPinChange(
        onPressButton: () {
          context.pop();
        },
      );
    },
  );
}

class ModalDialogPinChange extends StatelessWidget {
  const ModalDialogPinChange({
    super.key,
    required this.onPressButton,
  });

  final void Function()? onPressButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Container()),
            const Text(
              'PIN changed succesfully ?',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'You account is well protected with your new transaction PIN',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            RexElevatedButton(
              onPressed: onPressButton,
              buttonTitle: 'Ok',
              backgroundColor: null,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
