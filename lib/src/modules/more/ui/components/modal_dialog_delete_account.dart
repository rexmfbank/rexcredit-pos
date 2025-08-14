import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

void modalDialogDeleteAccount({
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
      return ModalDialogDeleteAccount(
        onPressYesButton: () {},
        onPressCancelButton: () {
          context.pop();
        },
      );
    },
  );
}

class ModalDialogDeleteAccount extends StatelessWidget {
  const ModalDialogDeleteAccount({
    super.key,
    this.onPressYesButton,
    this.onPressCancelButton,
  });

  final void Function()? onPressYesButton;
  final void Function()? onPressCancelButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 180,
                child: Lottie.asset('assets/lottiefiles/warning-status.json')),
            const Text(
              'Delete Account?',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('Are you sure you want to delete your account?'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextButton(
                    onPressed: onPressCancelButton,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.rexWhite,
                      foregroundColor: AppColors.rexPurpleLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fixedSize: const Size.fromHeight(48),
                      side: const BorderSide(color: AppColors.rexBlack),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextButton(
                    onPressed: onPressYesButton,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.rexWhite,
                      backgroundColor: AppColors.rexPurpleLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fixedSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Yes, Delete'),
                  ),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
