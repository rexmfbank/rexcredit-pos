import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_pin_dialog.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/fund_saving_sheet_title.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

void showFundDepositSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        final userAcctBalance = ref.watch(userAcctBalanceProvider);
        final bal = userAcctBalance.asData?.value.data?.availableBalance ?? '';
        final depositState = ref.watch(fixedDepositProvider);
        //
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FundSavingSheetTitle(
                  onTap: () => context.pop(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Text(StringAssets.fundSavingAmount(depositState
                          .amountController.text
                          .formatCurrencyString())),
                      const SizedBox(height: 8.0),
                      ListTile(
                        contentPadding: const EdgeInsets.all(4.0),
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            StringAssets.fundSave1,
                            style: _modTextStyle,
                          ),
                        ),
                        subtitle: Text(
                            "Account balance\n${bal.toString().formatCurrencyString()}"),
                        trailing: const Icon(Icons.navigate_next),
                        isThreeLine: true,
                        shape: _modBorder,
                        onTap: () {
                          showTransferPinModalSheet(
                            context: context,
                            onPinEntered: (value) {
                              ref
                                  .read(fixedDepositProvider.notifier)
                                  .setTransactionPin(value);
                              ref
                                  .read(fixedDepositProvider.notifier)
                                  .setFundingByAccount(context);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

const _modTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: AppColors.rexPurpleDark,
);

final _modBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(14),
  side: const BorderSide(color: Colors.black),
);
