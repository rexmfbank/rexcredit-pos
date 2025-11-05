import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/pin_input_layout.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showConfirmPinModalSheet({
  required BuildContext context,
  required String title,
  String? subtitle,
  required Function(String) onPinEntered,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.rexBlack,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                subtitle ?? Strings.pleaseEnterPinToProceed,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.rexPurpleLight,
                ),
              ),
              SizedBox(height: 10.h),
              PinInputLayout(onPinEntered: onPinEntered),
            ],
          ),
        ),
      );
    },
  );
}
