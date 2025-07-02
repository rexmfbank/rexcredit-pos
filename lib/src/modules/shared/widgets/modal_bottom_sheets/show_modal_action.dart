import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_double_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

Future<void> showExitModal({
  required BuildContext context,
  required String subtitle,
  String? title,
  String? lottie,
  VoidCallback? onTap,
  VoidCallback? doubleButton1Tap,
  VoidCallback? doubleButton2Tap,
  bool useDoubleButton = false,
  String? doubleButtonTitle1,
  String? doubleButtonTitle2,
}) async {
  return showModalAction(
    context: context,
    useDoubleButton: useDoubleButton,
    dialogTitle: title ?? StringAssets.hiThere,
    dialogSubtitle: subtitle,
    doubleButtonTitle1: doubleButtonTitle1,
    doubleButtonTitle2: doubleButtonTitle2,
    doubleButton1Tap: doubleButton1Tap,
    doubleButton2Tap: doubleButton2Tap,
    onPressed: () => onTap != null ? onTap.call() : context.pop(),
    lottieAnimation: LottieBuilder.asset(lottie ?? LottieAsset.loginAnimation),
  );
}

void showModalActionError({
  required BuildContext context,
  required String errorText,
  String? title,
  String? lottieAnimation,
  double? height,
  double? width,
  VoidCallback? onTap,
  bool isDismissible = false,
}) {
  return showModalAction(
    context: context,
    dialogTitle: title ?? 'An error occurred.',
    dialogSubtitle: errorText,
    isDismissible: isDismissible,
    onPressed: () => onTap != null ? onTap.call() : context.pop(),
    lottieAnimation: LottieBuilder.asset(
      lottieAnimation ?? AssetPath.warningStatus,
      height: height ?? 110.ah,
      width: width ?? 110.aw,
    ),
  );
}

void showModalActionSuccess({
  required BuildContext context,
  required String subtitle,
  String? title,
  required void Function()? onPressed,
  bool isDismissible = false,
  bool enableDrag = true,
}) {
  return showModalAction(
    context: context,
    dialogTitle: title ?? 'Success',
    dialogSubtitle: subtitle,
    onPressed: onPressed,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}

void showModalActionCustom({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String assetPath,
  required void Function()? onPressed,
  bool isDismissible = false,
}) {
  return showModalAction(
    context: context,
    dialogTitle: title,
    dialogSubtitle: subtitle,
    onPressed: onPressed,
    isDismissible: isDismissible,
    lottieAnimation: LottieBuilder.asset(assetPath),
  );
}

showModalForInwardNotification(
  BuildContext context,
  String message,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isDismissible: false,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    // height: AppConstants.deviceHeight - 30.ah,
    builder: (context) {
      return SizedBox(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.aw,
            right: 12.aw,
            top: 12.ah,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150.ah,
                child: LottieBuilder.asset(AssetPath.successTick),
              ),
              SizedBox(height: 8.ah),
              Text(
                "Payment Received.",
                style: TextStyle(
                  fontSize: 18.asp,
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.ah),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.ah),
              Row(
                children: [
                  Flexible(
                    child: RexElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      buttonTitle: "OK",
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: RexElevatedButton(
                      onPressed: () {},
                      buttonTitle: "Print Receipt",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.ah),
            ],
          ),
        ),
      );
    },
  );
}

void showModalAction({
  required BuildContext context,
  required String dialogTitle,
  required String dialogSubtitle,
  void Function()? onPressed,
  VoidCallback? doubleButton1Tap,
  VoidCallback? doubleButton2Tap,
  String? buttonTitle,
  String? doubleButtonTitle1,
  String? doubleButtonTitle2,
  Widget? lottieAnimation,
  bool isDismissible = false,
  bool enableDrag = true,
  bool useDoubleButton = false,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return SizedBox(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.aw,
            right: 12.aw,
            top: 12.ah,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150.ah,
                child: lottieAnimation ??
                    LottieBuilder.asset(AssetPath.successTick),
              ),
              SizedBox(height: 8.ah),
              Text(
                dialogTitle,
                style: TextStyle(
                  fontSize: 18.asp,
                  color: AppColors.rexPurpleDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.ah),
              Text(
                dialogSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.ah),
              useDoubleButton
                  ? RexDoubleButton(
                      button1Title: doubleButtonTitle1 ?? 'Yes',
                      button2Title: doubleButtonTitle2 ?? 'No',
                      button1Color: AppColors.rexPurpleLight,
                      button2Color: AppColors.rexWhite,
                      button1Tap: doubleButton1Tap,
                      button2Tap: doubleButton2Tap,
                      buttonBorder2Color: AppColors.rexRedDark,
                      buttonText2Color: AppColors.rexRedDark,
                      margin: 50.aw,
                    )
                  : RexElevatedButton(
                      onPressed: onPressed,
                      buttonTitle: buttonTitle ?? 'Okay',
                      backgroundColor: null,
                    ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      );
    },
  );
}
