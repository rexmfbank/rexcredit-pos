import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/currency.dart';

class TopUpSuccessDepositInfoWidget extends StatelessWidget {
  final String depositAmount;
  final String? nextSavingsDate;

  const TopUpSuccessDepositInfoWidget({
    required this.depositAmount,
    this.nextSavingsDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.rexBackground,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0, top: 24.0),
            child: Text(
              "Deposit amount",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8.0),
            child: Text(
              addNairaCurrencySymbol(depositAmount),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey.withAlpha(90),
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 4.0),
            child: Text(
              "Next Payment Date",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.rexTint500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 18.0,
              top: 8.0,
              bottom: 18,
            ),
            child: Text(
              "Aug 30, 2023", //maturityDate,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
