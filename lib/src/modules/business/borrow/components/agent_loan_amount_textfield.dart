import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class AgentLoanAmountTextField extends StatelessWidget {
  const AgentLoanAmountTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loanAmountController = TextEditingController();

    return TextField(
      controller: loanAmountController,
      style: TextStyle(
        color: AppColors.textBlack,
        fontSize: 24.sp,
      ),
      keyboardType: TextInputType.number,
      cursorColor: AppColors.rexPurpleLight,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 .]'))],
      decoration: InputDecoration(
        hintText: '₦0.00',
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        prefixStyle: TextStyle(
          color: AppColors.textBlack,
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      //onChanged: (value) => viewModel.loanAmountValidation(),
    );
  }
}
