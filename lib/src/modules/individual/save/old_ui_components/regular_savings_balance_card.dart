import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/hide_balance.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_dialog_button.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/show_regular_savings_modal.dart';
import 'package:rex_app/src/utils/currency.dart';

class RegularSavingsBalanceCard extends HookConsumerWidget {
  const RegularSavingsBalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Savings Wallet',
                style: TextStyle(
                  color: AppColors.rexPurpleDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              HideBalanceSwitch(),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              addNairaCurrencySymbol('0.00'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: SavingsDialogButton(
                  onPressed: () {
                    showRegularSavingsModalSheet(
                        context: context,
                        planId: 0,
                        balance: "400",
                        type: 'Withdrawal',
                        maturityDate: "2023-09-14");
                  },
                  textColor: AppColors.rexPurpleDark,
                  title: 'Withdraw',
                  hasIcon: false,
                  backgroundColor: AppColors.rexBackground,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: SavingsDialogButton(
                  onPressed: () {
                    showRegularSavingsModalSheet(
                        context: context,
                        planId: 0,
                        balance: "400",
                        type: 'TopUp',
                        maturityDate: "2023-09-14");
                    // showSavingsTopUpModalSheet(context: context, planId: 0);
                  },
                  textColor: AppColors.rexWhite,
                  hasIcon: false,
                  title: 'Save',
                  backgroundColor: AppColors.rexPurpleLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
