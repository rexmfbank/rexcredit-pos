import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showStatusModal({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String buttonText,
  required bool isSuccess,
  required VoidCallback onButtonPressed,
  required VoidCallback onCloseTapped,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    backgroundColor: AppColors.rexWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (context) {
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: onCloseTapped,
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.rexPurpleLight,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: Lottie.asset(
                    isSuccess ? AssetPath.successTick : AssetPath.warningStatus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                RexFlatButton(
                  onPressed: onButtonPressed,
                  buttonTitle: buttonText,
                  textColor: AppColors.rexWhite,
                  backgroundColor: AppColors.rexPurpleLight,
                ),
                // RexFlatButton(
                //   onPressed: onCloseTapped,
                //   buttonTitle: StringAssets.done,
                //   textColor: AppColors.rexPurpleLight,
                //   backgroundColor: AppColors.rexPurpleLight.withOpacity(0.2),
                //   borderColor: AppColors.rexPurpleLight,
                // )
              ],
            ),
          ),
        );
      });
    },
  );
}
