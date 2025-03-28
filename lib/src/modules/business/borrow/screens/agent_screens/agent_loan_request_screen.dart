import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/borrow/components/agent_loan_amount_textfield.dart';
import 'package:rex_app/src/modules/business/borrow/components/agent_loan_duration_dropdown.dart';
import 'package:rex_app/src/modules/business/borrow/components/agent_loan_purpose_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AgentLoanRequestScreen extends StatelessWidget {
  const AgentLoanRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Apply for a loan',
        subtitle: '',
        hasActionButton: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              StringAssets.availableLoan(150000.00, '₦'),
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Align(
            alignment: Alignment.center,
            child: IntrinsicWidth(
              child: AgentLoanAmountTextField(),
            ),
          ),
          Divider(
            height: 0.5.h,
            color: AppColors.darkGrey,
            indent: 20.w,
            endIndent: 20.w,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Text(
              StringAssets.recommendedLoansSubtitle,
              style: TextStyle(
                color: AppColors.rexTint500,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const AgentLoanDurationDropdown(),
          const AgentLoanPurposeDropdown(),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: RexElevatedButton(
              onPressed: () {},
              buttonTitle: 'Submit',
            ),
          ),
        ],
      ),
    );
  }
}
