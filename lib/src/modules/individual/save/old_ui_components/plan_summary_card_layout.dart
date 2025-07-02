import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text_title.dart';

class PlanSummaryCardLayout extends StatelessWidget {
  final String targetAmount;
  final String wht;
  final String payoutAmount;
  final String maturityDate;
  final String interestRate;
  final String interestAmount;
  final String savingsTenor;
  final String frequency;
  final String amountToSave;
  final String autosave;

  const PlanSummaryCardLayout({
    Key? key,
    this.targetAmount = '',
    this.wht = '',
    this.payoutAmount = '',
    this.maturityDate = '',
    this.interestRate = '',
    this.savingsTenor = '',
    this.frequency = '',
    this.amountToSave = '',
    this.autosave = 'No',
    this.interestAmount = '',
  }) : super(key: key);

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
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(
                          title: 'Target Savings Amount'),
                      PlanSummaryItemText(value: targetAmount),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Interest Rate'),
                      PlanSummaryItemText(value: interestRate),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Savings tenor'),
                      PlanSummaryItemText(value: savingsTenor),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Autosave'),
                      PlanSummaryItemText(value: autosave),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(
                          title: 'Amount to save now'),
                      PlanSummaryItemText(value: amountToSave),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Frequency'),
                      PlanSummaryItemText(value: frequency),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Interest Amount'),
                      PlanSummaryItemText(value: interestAmount),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PlanSummaryItemTitleText(title: 'Maturity date'),
                      PlanSummaryItemText(value: maturityDate),
                    ],
                  ),
                ),
              ],
            ),
            const PlanSummaryDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlanSummaryItemTitleText(title: 'Payout Amount'),
                PlanSummaryItemText(value: payoutAmount),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: Text(
                '*$wht  WHT has been applied',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cardGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
