import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class TerminateOrRepayLoanButtons extends StatelessWidget {
  const TerminateOrRepayLoanButtons({
    super.key,
    required this.onClickTerminate,
    required this.onClickMakeRepayment,
  });

  final void Function()? onClickTerminate;
  final void Function()? onClickMakeRepayment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexBackground,
                foregroundColor: AppColors.rexPurpleLight,
                side: const BorderSide(color: AppColors.borderGrey),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              onPressed: onClickTerminate,
              child: const Text('Terminate'),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexPurpleLight,
                foregroundColor: AppColors.rexWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: onClickMakeRepayment,
              child: const Text('Make Repayment'),
            ),
          ),
        ],
      ),
    );
  }
}
