import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:go_router/go_router.dart';

void emptyNubanModalSheet({
  required BuildContext context,
  required String firstName,
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
      return DashboardModalDialogNuban(
        firstName: firstName,
        onPressButton: () {
          context.pop();
        },
      );
    },
  );
}

class DashboardModalDialogNuban extends StatelessWidget {
  const DashboardModalDialogNuban({
    super.key,
    required this.firstName,
    required this.onPressButton,
  });

  final String firstName;
  final void Function()? onPressButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Hi $firstName",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'You do not have a NUBAN yet. Please complete sign up.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppColors.cardGrey,
                  height: 1.7,
                ),
              ),
            ),
            RexFlatButton(
              onPressed: onPressButton,
              buttonTitle: 'Okay',
              backgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}
