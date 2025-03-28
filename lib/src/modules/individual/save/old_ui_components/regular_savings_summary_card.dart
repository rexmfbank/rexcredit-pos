import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text_title.dart';

class RegularSavingsSummaryCard extends StatelessWidget {
  final String savingsAmount;
  final String interestRate;
  final String savingsTenor;
  final String frequency;
  final String amountToSave;
  final String autosave;

  const RegularSavingsSummaryCard({
    Key? key,
    this.savingsAmount = '',
    this.interestRate = '',
    this.savingsTenor = '',
    this.frequency = '',
    this.amountToSave = '',
    this.autosave = 'No',
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
                      const PlanSummaryItemTitleText(title: 'Savings Amount'),
                      PlanSummaryItemText(value: savingsAmount),
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
                        title: 'Recurring amount to save',
                      ),
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
          ],
        ),
      ),
    );
  }
}
