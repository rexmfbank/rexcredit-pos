import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/date_utils/change_date_format.dart';

class RegularSavingsTransactionCardItem extends HookConsumerWidget {
  final SavingsTransactionData data;

  const RegularSavingsTransactionCardItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final logger = ref.watch(loggerProvider);

    String getImageAssetPath() {
      if (data.transactionType == "Savings top up") {
        return 'assets/png/savings_deposit_icon.png';
      } else {
        return 'assets/png/savings_withdrawal_icon.png';
      }
    }

    Color getColorByStatus() {
      if (data.status == "successful") {
        return Colors.green;
      } else if (data.status == "pending") {
        return Colors.amber;
      } else {
        return AppColors.red;
      }
    }

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
            getImageAssetPath(),
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
                      data.transactionType,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                    Text(
                      addNairaCurrencySymbol(data.amount),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      changeDateFormat("yyyy-MM-dd", "MMM dd, yyy", data.date),
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 12, color: AppColors.rexTint500),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      data.status,
                      style: TextStyle(fontSize: 12, color: getColorByStatus()),
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

class SavingsTransactionData {
  final String transactionType;
  final String status;
  final String date;
  final String amount;

  SavingsTransactionData({
    required this.transactionType,
    required this.status,
    required this.date,
    required this.amount,
  });
}
