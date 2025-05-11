import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';

class PendingLoanApplicationDetails extends ConsumerWidget {
  const PendingLoanApplicationDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanApplication = ref.watch(selectedLoanApplicationProvider) ??
        LoanApplicationResponseData.empty();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  StringAssets.requestedLoanAmountTitle,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  addNairaCurrencySymbol(
                      loanApplication.amountApplied.toNairaAmountFormat()),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          const Divider(color: AppColors.borderGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringAssets.duration,
                      style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      StringAssets.requestedLoanDuration(
                          loanApplication.tenor!),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                  height: 80,
                  child: VerticalDivider(color: AppColors.borderGrey)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringAssets.repaymentAmount,
                      style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      addNairaCurrencySymbol(loanApplication
                              .repayment?.periodicRepaymentAmount!
                              .toCurrencyString() ??
                          '0.00'),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
