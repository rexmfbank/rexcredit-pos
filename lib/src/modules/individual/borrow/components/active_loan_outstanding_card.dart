import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/components/terminate_or_repay_loan_widget.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_management_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';

class ActiveLoanOutstandingCard extends ConsumerWidget {
  const ActiveLoanOutstandingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(loanManagementProvider).loanDetail;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringAssets.nextRepayment,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                addNairaCurrencySymbol(loanDetail?.repaymentSchedule
                        ?.firstWhere((element) => element.status != 'PAID')
                        .amountDue
                        ?.toNairaAmountFormat() ??
                    '0.00'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'Your total outstanding loan is ${addNairaCurrencySymbol(loanDetail?.totalOutstanding?.toCurrencyString() ?? '0.00')}',
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.rexTint500),
          ),
          const SizedBox(height: 10.0),
          loanDetail?.appStatus == 'ACTIVE'
              ? TerminateOrRepayLoanButtons(
                  onClickTerminate: () {
                    context.push(
                        "${Routes.dashboardBorrow}/${Routes.indLoanTermination}");
                  },
                  onClickMakeRepayment: () {
                    context.push(
                        "${Routes.dashboardBorrow}/${Routes.indLoanPartPayment}");
                  },
                )
              : Container(
                  height: 8.0,
                ),
        ],
      ),
    );
  }
}
