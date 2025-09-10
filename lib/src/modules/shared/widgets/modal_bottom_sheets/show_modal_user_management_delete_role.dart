import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

void showModalUserManagementDeleteRole({
  required BuildContext context,
  required void Function()? yesButton,
  required void Function()? cancelButton,
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
              Expanded(
                child: Container(),
              ),
              const Text(
                'Delete Role?',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.rexPurpleDark,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Are you sure you want to delete role?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: RexElevatedButton(
                      onPressed: cancelButton,
                      buttonTitle: 'Cancel',
                      backgroundColor: AppColors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: RexElevatedButton(
                      onPressed: yesButton,
                      buttonTitle: 'Yes, delete',
                      backgroundColor: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      );
    },
  );
}
