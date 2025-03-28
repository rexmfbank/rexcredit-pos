import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/user_account_balance_provider.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/fund_saving_sheet_title.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

void showFundSavingTopup({
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
        final savingsState = ref.watch(targetSavingProvider);
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
                      SizedBox(height: 8.ah),
                      Text(StringAssets.fundSavingAmount(savingsState
                          .topupController.text
                          .formatCurrencyString())),
                      SizedBox(height: 8.ah),
                      ListTile(
                        contentPadding: const EdgeInsets.all(4.0),
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            StringAssets.fundSave1,
                            style: _modTextStyle,
                          ),
                        ),
                        subtitle: Text("Account balance\n\u20A6$bal"),
                        trailing: const Icon(Icons.navigate_next),
                        isThreeLine: true,
                        shape: _modBorder,
                        onTap: () {
                          ref
                              .read(targetSavingProvider.notifier)
                              .topupSavingByAccount(context);
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
