import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_summary_card.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/savings_providers.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/topup_saving_widget.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class SavingItemDetailScreenBody extends ConsumerWidget {
  const SavingItemDetailScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingsItem = ref.watch(inMemoryTargetSavingData);
    final targetSavingState = ref.watch(targetSavingProvider);

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
                  item: savingsItem.planName,
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Frequency',
                  item: savingsItem.frequency,
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Status',
                  item: savingsItem.status,
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Target amount',
                  item: savingsItem.targetAmount.formatCurrencyString(),
                ),
                const PlanSummaryDivider(),
                TransactionSummaryItem(
                  title: 'Total amount saved',
                  item: savingsItem.totalAmount.formatCurrencyString(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            ref.read(targetSavingProvider.notifier).setTopupSavingShowInput();
          },
          child: const Text(
            'Topup savings',
            style: TextStyle(
              color: AppColors.rexPurpleDark,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 16),
        targetSavingState.topupSavingShowInput
            ? const TopupSavingWidget()
            : Container(),
      ],
    );
  }
}
