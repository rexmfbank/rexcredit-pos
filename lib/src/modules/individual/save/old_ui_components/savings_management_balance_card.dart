import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';

class SavingsManagementBalanceCard extends StatelessWidget {
  final String balance;
  final String targetAmount;

  const SavingsManagementBalanceCard({
    super.key,
    required this.balance,
    required this.targetAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 26.0, bottom: 26),
      child: Row(
        children: [
          Image.asset(
            'assets/png/save_balance_icon.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Savings balance',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.rexTint500,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                addNairaCurrencySymbol(balance),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(width: 36),
          Row(
            children: [
              Image.asset(
                'assets/png/target_icon.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringAssets.savingsPlanTargetAmount,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.rexTint500,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    addNairaCurrencySymbol(targetAmount),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
