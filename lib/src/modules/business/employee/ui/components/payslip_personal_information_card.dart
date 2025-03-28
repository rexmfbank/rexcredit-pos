import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';

class PayslipPersonalInfromationCard extends StatelessWidget {
  final String accountName;
  final String accountNumber;
  final String bankName;

  const PayslipPersonalInfromationCard(
      {Key? key,
      required this.accountName,
      required this.accountNumber,
      required this.bankName})
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
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Account Name:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: accountName),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Account Number:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: accountNumber),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Bank Name:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: PlanSummaryItemText(value: bankName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
