import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:sprintf/sprintf.dart';
import 'package:go_router/go_router.dart';

void emptyDocumentModalSheet({
  required BuildContext context,
  String name = 'User',
}) {
  String formattedName = sprintf(
    StringAssets.additionalDetailsNeededTitle,
    [name],
  );
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
      return DashboardModalDialogDocument(
        firstName: formattedName,
        onSkip: () => context.pop(),
        onPressButton: () => context.go(
          "${Routes.dashboardMore}/${Routes.updateAccount}",
        ),
      );
    },
  );
}

class DashboardModalDialogDocument extends StatelessWidget {
  const DashboardModalDialogDocument({
    super.key,
    required this.firstName,
    required this.onSkip,
    required this.onPressButton,
  });

  final String firstName;
  final void Function()? onSkip;
  final void Function()? onPressButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    firstName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                StringAssets.additionalDetailsNeededSubtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppColors.cardGrey,
                  height: 1.7,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            RexFlatButton(
              onPressed: onPressButton,
              buttonTitle: 'Add details now',
              backgroundColor: null,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: GestureDetector(
                onTap: onSkip,
                child: Text(
                  "I'll do this later",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.cardGrey,
                    decoration: TextDecoration.underline,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
