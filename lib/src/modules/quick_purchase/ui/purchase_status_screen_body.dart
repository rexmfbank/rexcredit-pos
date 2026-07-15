import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/int_ext.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_pagination_notifier.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

class PurchaseStatusScreenBody extends ConsumerStatefulWidget {
  const PurchaseStatusScreenBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseStatusScreenBodyState();
}

class _PurchaseStatusScreenBodyState
    extends ConsumerState<PurchaseStatusScreenBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posCardPurchaseProvider);
    return Padding(
      padding: EdgeInsets.all(12.ar),
      child: ListView(
        children: [
          SizedBox(height: 15.ah),
          state.purchaseStatusCode == '00'
              ? Icon(Icons.check_circle, color: AppColors.rexGreen, size: 60)
              : Icon(Icons.close, color: AppColors.red, size: 60),
          20.spaceHeight(),
          Text(
            state.purchaseStatusCode == '00'
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
                      state.baseappAmount.formatAmount(),
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
                      state.baseappTransType,
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
                        state.purchaseStatusCode == '00'
                            ? 'Successful'
                            : state.purchaseMessage,
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
                      state.baseappStan,
                      style: AppTextStyles.transactionStatus,
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.spaceHeight(),
          RexElevatedButton(
            onPressed: () {
              ref
                  .read(posCardPurchaseProvider.notifier)
                  .doPrinting(copyType: 'MERCHANT COPY');
            },
            buttonTitle: 'Print Receipt',
          ),
          RexElevatedButton(
            backgroundColor: AppColors.rexTint400,
            isDisabled: state.isLoading,
            onPressed: () {
              ref.invalidate(posPaginationProvider);
              ref.read(posCardPurchaseProvider.notifier).clearState();
              if (state.isQuickPurchase) {
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
