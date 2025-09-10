import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/account_balance_text.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/hide_balance.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/account_card/add_or_transfer_buttons.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/mixin/app_actions_mixin.dart';

class DashboardAccount extends ConsumerWidget with AppActionsMixin {
  const DashboardAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nubanString = ref.watch(userNubanProvider);
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
              StringAssets.activeText,
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
                        ClipboardData(text: nubanString),
                      ).then(
                        (value) => context.showToast(
                          message: StringAssets.accountNumberCopied,
                        ),
                      ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(nubanString),
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
                  child: HideBalanceSwitch(),
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
                    ref.refresh(userAcctBalanceProvider);
                    ref.refresh(
                      userRecentTransactionProvider(
                        const RecentTransactionParam(
                          startDate: '',
                          endDate: '',
                        ),
                      ),
                    );
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
