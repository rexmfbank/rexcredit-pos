import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/transaction_dispute_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/all_transactions/transaction_summary_card.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class TransactionDisputeScreenBody extends ConsumerWidget {
  const TransactionDisputeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(inMemoryRecentTransaction);
    final disputeProvider = ref.watch(transactionDisputeProvider);
    //
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _DisputeInfo(data: data),
        const SizedBox(height: 12.0),
        RexTextField(
          controller: disputeProvider.textController,
          outerTitle: 'Enter a message',
          showOuterTile: true,
          textFieldIsRequired: true,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: RexElevatedButton(
            onPressed: () {
              ref
                  .read(transactionDisputeProvider.notifier)
                  .validateInput(context);
            },
            buttonTitle: 'Submit report',
          ),
        ),
      ],
    );
  }
}

class _DisputeInfo extends StatelessWidget {
  const _DisputeInfo({
    required this.data,
  });

  final TransferData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 16.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TransactionSummaryItem(
              title: 'Amount',
              item: data.amount?.formatCurrencyNum() ?? 'n/a',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Beneficiary',
              item: data.beneficiaryName ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: 'Beneficiary Account',
              item: data.beneficiaryAccountNumber ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }
}
