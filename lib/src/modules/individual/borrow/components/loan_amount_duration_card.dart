import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_calculation_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';

class LoanAmountDurationCard extends ConsumerWidget {
  const LoanAmountDurationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loanRepaymentData = ref.watch(loanCalculationProvider);

    var monthlyRepaymentAmount = loanRepaymentData
        .computedLoan?.periodicRepaymentAmount!
        .toNairaAmountFormat();
    var totalRepaymentAmount = loanRepaymentData.computedLoan?.repaymentAmount!
        .toNairaAmountFormat();
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(StringAssets.periodicRepaymentAmount,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              addNairaCurrencySymbol(monthlyRepaymentAmount ?? '0.0'),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Text(
            'Your total repayment over the loan duration of ${loanRepaymentData.selectedTenor} months is ',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.cardGrey,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            addNairaCurrencySymbol(totalRepaymentAmount ?? '0.0'),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.cardGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'This is an example of a loan offer and can be changed.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.cardGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
