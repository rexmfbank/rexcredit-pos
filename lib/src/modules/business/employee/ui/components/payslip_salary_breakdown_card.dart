import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';

class PayslipPersonalSalaryBreakdownCard extends StatelessWidget {
  final String basic;
  final String transport;
  final String housing;
  final String deduction;
  final String bonus;
  final String tax;

  const PayslipPersonalSalaryBreakdownCard(
      {Key? key,
      required this.basic,
      required this.transport,
      required this.bonus,
      required this.housing,
      required this.deduction,
      required this.tax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24.0,
          bottom: 24.0,
          right: 16.0,
          left: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Salary Breakdown',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Basic:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: basic),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Housing:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: housing),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Transport:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: transport),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Bonus:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: bonus),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Deduction:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: deduction),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Tax:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: tax),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
