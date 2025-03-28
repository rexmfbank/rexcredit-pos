import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showModalSheetForDeviceVerification({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 32.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringAssets.newDeviceTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const Flexible(
              child: Text(StringAssets.newDeviceSubtitle),
            ),
            RexElevatedButton(
              onPressed: () {},
              buttonTitle: 'Yes',
              backgroundColor: null,
            ),
          ],
        ),
      );
    },
  );
}
