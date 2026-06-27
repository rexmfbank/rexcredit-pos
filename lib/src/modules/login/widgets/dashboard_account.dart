// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/login/widgets/account_balance_text.dart';
import 'package:rex_app/src/modules/login/widgets/add_or_transfer_button.dart';
import 'package:rex_app/src/modules/login/widgets/app_actions_mixin.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/utils/app_keys.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardAccount extends ConsumerWidget with AppActionsMixin {
  const DashboardAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nubanString = AppKeysStorage.getConfig().loginNuban;
    final state = ref.watch(dashboardProvider);
    //
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.all(16.ar),
      color: AppColors.rexWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.ar)),
      child: Padding(
        padding: EdgeInsets.all(12.ar),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.activeText,
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.rexGreen,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap:
                      () => Clipboard.setData(
                        ClipboardData(text: state.balanceAcctName),
                      ).then(
                        (value) => context.showSnack(
                          message: Strings.accountNumberCopied,
                        ),
                      ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.balanceAcctNo),
                      SizedBox(width: 4.aw),
                      Icon(
                        Icons.copy_outlined,
                        size: 10.ar,
                        color: AppColors.rexPurpleLight,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: SizedBox.shrink(), // HideBalanceSwitch(),
                ),
              ],
            ),
            SizedBox(height: 12.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AccountBalanceText(),
                InkWell(
                  onTap: () {
                    ref.read(dashboardProvider.notifier).fetchBalance();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.aw),
                    child: Icon(
                      Icons.refresh,
                      size: 22.ar,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.ah),
            AddOrTransferButtons(
              onClickAddMoney: () {
                context.push(
                  '${Routes.dashboardIndividual}/${Routes.dashboardBankTransfer}',
                );
              },
              onClickTransferMoney: () {
                context.push(
                  '${Routes.dashboardIndividual}/${Routes.transferTabPage}',
                );
              },
            ),
            SizedBox(height: 10.ah),
          ],
        ),
      ),
    );
  }
}
