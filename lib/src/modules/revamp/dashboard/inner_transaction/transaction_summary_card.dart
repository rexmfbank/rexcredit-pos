import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/dashboard/inner_transaction/summary_divider.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/string_utils.dart';

class TransactionsSummaryCard extends ConsumerWidget {
  const TransactionsSummaryCard({super.key, required this.transData});

  final TransferData transData;

  // "tranCode": "Card Purchase",
  // "tranType": "PURCHASE",

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              title: StringAssets.transactionRef,
              item: transData.tranUniqueRefNo ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.transactionStatus,
              item: transData.transactionStatus ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.transactionDate,
              item:
                  transData.transactionDate == null
                      ? 'N/A'
                      : '${transData.transactionDate!.dateReadable()} : ${DateFormat.jm().format(transData.transactionDate!)}',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.amount,
              item: transData.amount?.formatCurrencyNum() ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.description,
              item: transData.narration ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.beneficiary,
              item: transData.beneficiaryName.toTitleCase() ?? 'N/A',
            ),
            const PlanSummaryDivider(),
            TransactionSummaryItem(
              title: StringAssets.beneficiaryAccount,
              item: transData.beneficiaryAccountNumber ?? 'N/A',
            ),
            transData.tranType == "PURCHASE"
                ? SizedBox.shrink()
                : SenderDetails(transData: transData),
          ],
        ),
      ),
    );
  }
}

class SenderDetails extends StatelessWidget {
  const SenderDetails({super.key, required this.transData});

  final TransferData transData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PlanSummaryDivider(),
        TransactionSummaryItem(
          title: StringAssets.senderName,
          item: transData.senderName.toTitleCase() ?? 'N/A',
        ),
        const PlanSummaryDivider(),
        TransactionSummaryItem(
          title: StringAssets.senderAccount,
          item: transData.senderAccountNumber ?? 'N/A',
        ),
      ],
    );
  }
}

class TransactionSummaryItem extends StatelessWidget {
  const TransactionSummaryItem({
    super.key,
    required this.title,
    required this.item,
  });

  final String title;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(title, style: _titleText)),
          Expanded(flex: 5, child: Text(item, style: _itemText)),
        ],
      ),
    );
  }
}

const _titleText = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: AppColors.rexTint500,
);

const _itemText = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500);
