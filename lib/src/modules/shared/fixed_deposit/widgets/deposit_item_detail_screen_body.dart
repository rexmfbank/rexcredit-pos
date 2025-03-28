import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_summary_card.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/deposit_providers.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class DepositItemDetailScreenBody extends ConsumerWidget {
  const DepositItemDetailScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depositItem = ref.watch(inMemoryFixedDepositData);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 16),
        Container(
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
                  title: 'Plan name',
                  item: depositItem.planName ?? 'Not available',
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Amount',
                  item: depositItem.amount?.formatCurrencyString() ?? 'N/A',
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Maturity date',
                  item: depositItem.maturityDate?.dateReadable() ?? 'N/A',
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Status',
                  item: depositItem.status ?? 'N/A',
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Interest',
                  item: depositItem.interestAccrued?.formatCurrencyString() ??
                      'N/A',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
