import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showModalConfirmSalaryBank({
  required BuildContext context,
  required TextEditingController textController,
  required void Function()? onPressed,
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
      return SizedBox(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm salary bank details',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.rexPurpleDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Flexible(
                child: Text(
                    'Please enter OTP code sent to the phone number registeres to your BVN'),
              ),
              const SizedBox(height: 16.0),
              RexTextField(
                outerTitle: 'OTP Code',
                hintText: '123456',
                controller: textController,
                obscureText: false,
              ),
              RexElevatedButton(
                onPressed: onPressed,
                buttonTitle: StringAssets.nextTextOnButton,
                backgroundColor: null,
              ),
            ],
          ),
        ),
      );
    },
  );
}
