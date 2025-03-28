import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text_title.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class FixedDepositSummaryCard extends StatelessWidget {
  const FixedDepositSummaryCard({
    super.key,
    required this.depositData,
  });

  final DepositInterestRateData depositData;

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
          bottom: 24.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(
                        title: 'Investment Amount',
                      ),
                      PlanSummaryItemText(
                        value: depositData.amount?.formatCurrencyNum() ?? 'N/A',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Interest Rate'),
                      PlanSummaryItemText(value: "${depositData.rate}%"),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Duration(days)'),
                      PlanSummaryItemText(value: "${depositData.duration}"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Interest type'),
                      PlanSummaryItemText(value: "${depositData.interestType}"),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Payout amount'),
                      PlanSummaryItemText(
                        value: depositData.totalAmount?.formatCurrencyNum() ??
                            'N/A',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Maturity Date'),
                      PlanSummaryItemText(
                          value: "${depositData.maturityDate?.dateReadable()}"),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Interest'),
                      PlanSummaryItemText(
                        value:
                            depositData.interest?.formatCurrencyNum() ?? 'N/A',
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
