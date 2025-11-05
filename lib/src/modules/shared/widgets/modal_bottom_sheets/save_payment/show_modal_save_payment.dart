import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/save_payment/save_pay_frequency_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../app_rex_text_field.dart';

void showSavePaymentModal({required BuildContext context}) {
  showModalBottomSheet(
    backgroundColor: AppColors.rexWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.savePayment,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                Strings.enterRecurringPaymentDetails,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cardGrey,
                ),
              ),
              SizedBox(height: 15.h),
              const SavePayFrequencyDropdown(),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    Strings.saveAsRecurringPayment,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.rexPurpleLight,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              AppRexTextField(
                outerTitle: Strings.nextPaymentDate,
                hintText: '',
                controller: TextEditingController(),
                inputType: TextInputType.none,
                readOnly: true,
                isRequired: true,
                suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 24),
                backgroundColor: AppColors.rexBackground,
                onTap: () {
                  showDatePickerModal(context, DateTime.now());
                },
              ),
              SizedBox(height: 15.h),
              AppRexTextField(
                outerTitle: Strings.planName,
                hintText: '',
                isRequired: true,
                controller: TextEditingController(),
                backgroundColor: AppColors.rexBackground,
                validator: (value) => null,
              ),
              SizedBox(height: 15.h),
              RexElevatedButton(
                onPressed: () {},
                buttonTitle: Strings.savePayment,
                backgroundColor: null,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showDatePickerModal(BuildContext context, DateTime selectedDate) async {
  var datePicked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (datePicked != null && datePicked != selectedDate) {}
}
