import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_summary_card.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class LoanDetailSummary extends StatelessWidget {
  const LoanDetailSummary({
    super.key,
    required this.loanDetail,
  });

  final LoanDetail loanDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.ah, horizontal: 8.aw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TransactionSummaryItem(
              title: 'Loan Status',
              item: loanDetail.status?.value ?? 'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Loan Expected Payment',
              item: loanDetail.totalExpectedRepayment?.formatCurrencyNum() ??
                  'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Loan Principal',
              item: loanDetail.approvedPrincipal?.formatCurrencyNum() ?? 'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Loan Interest',
              item: loanDetail.loanInterest?.formatCurrencyNum() ?? 'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Outstanding',
              item: loanDetail.totalOutstanding?.formatCurrencyNum() ?? 'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Amount repaid',
              item: loanDetail.amountRepaid?.formatCurrencyNum() ?? 'n/a',
            ),
          ],
        ),
      ),
    );
  }
}
