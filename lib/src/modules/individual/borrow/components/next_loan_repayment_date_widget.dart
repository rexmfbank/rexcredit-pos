import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_management_provider.dart';
import 'package:rex_app/src/utils/date_utils/get_date_x_months_from_now.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

class NextLoanRepaymentDateWidget extends ConsumerWidget {
  const NextLoanRepaymentDateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(loanManagementProvider).loanDetail;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: AppColors.rexWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getMonth(loanDetail?.repaymentSchedule
                    ?.firstWhere((element) => element.status == 'Not Completed')
                    .dueDate),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.rexTint700,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                getDay(loanDetail?.repaymentSchedule
                    ?.firstWhere((element) => element.status == 'Not Completed')
                    .dueDate),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.rexBlack,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16.0),
          Text(
            'Next repayment is in ${loanDetail?.repaymentSchedule?.firstWhere((element) => element.status == 'Not Completed').dueDate.daysFromNow()} days',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
