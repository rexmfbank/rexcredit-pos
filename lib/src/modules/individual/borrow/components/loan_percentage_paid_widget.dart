import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_management_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/circular_savings_progress_widget.dart';

class LoanPercentagePaidWidget extends ConsumerWidget {
  const LoanPercentagePaidWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(loanManagementProvider).loanDetail;
    final percentage = loanDetail?.percentage ?? 0.0;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardBrown,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              loanDetail?.percentageText ??
                  'You have paid ${percentage.toInt()}% of your total loan amount',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.rexBrown2),
            ),
          ),
          const SizedBox(width: 12),
          CircularSavingsProgressWidget(
            size: 50.0,
            width: 7.0,
            percentage: percentage,
            backgroundColor: AppColors.rexBrown3,
            indicatorColor: AppColors.rexBrown2,
          )
        ],
      ),
    );
  }
}
