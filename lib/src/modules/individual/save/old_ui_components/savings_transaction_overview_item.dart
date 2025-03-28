import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/date_utils/change_date_format.dart';

class TransactionOverviewListItem extends StatelessWidget {
  final dynamic transactionData;

  const TransactionOverviewListItem({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.rexWhite,
      ),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/png/credit_icon.png',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transactionData.transactionType!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                    Text(
                      addNairaCurrencySymbol(transactionData.formatAmount!),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance: ${addNairaCurrencySymbol(transactionData.balance!.toInt().toString())}',
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 12, color: AppColors.rexTint500),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      changeDateFormat("yyyy-MM-dd", "MMM dd, yyy",
                          transactionData.transactionDate!),
                      style:
                          TextStyle(fontSize: 12, color: AppColors.rexTint500),
                    ),
                  ],
                ),
              ],
            ),
          ), // To occupy remaining space
        ],
      ),
    );
  }
}
