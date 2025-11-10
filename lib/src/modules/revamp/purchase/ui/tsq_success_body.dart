import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/int_ext.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TsqSuccessBody extends ConsumerWidget {
  const TsqSuccessBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseState = ref.watch(posCardPurchaseProvider);
    debugPrint('TSQ Success Body Rebuilt');
    debugPrint('TSQ Response: ${purchaseState.tsqTransData}');
    //
    return Padding(
      padding: EdgeInsets.all(12.ar),
      child: ListView(
        children: [
          SizedBox(height: 15.ah),
          purchaseState.tsqTransData.responseCode == '00'
              ? Icon(Icons.check_circle, color: AppColors.rexGreen, size: 60)
              : Icon(Icons.close, color: AppColors.red, size: 60),
          20.spaceHeight(),
          Text(
            purchaseState.tsqTransData.responseCode == '00'
                ? "Transaction Approved!"
                : "Transaction Declined",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          15.spaceHeight(),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount"),
                    Text(
                      "${purchaseState.tsqTransData.amount}",
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Type"),
                    Text(
                      purchaseState.tsqTransData.transactionType ?? 'n/a',
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Message"),
                    Flexible(
                      child: Text(
                        textAlign: TextAlign.right,
                        purchaseState.tsqTransData.responseCode == '00'
                            ? 'Successful'
                            : purchaseState.tsqTransData.status ?? 'n/a',
                        style: AppTextStyles.transactionStatus,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('STAN'),
                    Text(
                      purchaseState.tsqTransData.stan ?? 'N/A',
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.spaceHeight(),
          RexElevatedButton(
            onPressed:
                () => ref
                    .read(posCardPurchaseProvider.notifier)
                    .doPrintingInTsq('MERCHANT COPY'),
            buttonTitle: 'Print Receipt',
          ),
          RexElevatedButton(
            backgroundColor: AppColors.rexTint400,
            onPressed: () {
              ref.invalidate(userAcctBalanceProvider);
              if (purchaseState.isQuickPurchase) {
                context.go(Routes.homeScreen);
              } else {
                context.go(Routes.dashboardIndividual);
              }
            },
            buttonTitle: "Back to home",
          ),
        ],
      ),
    );
  }
}
