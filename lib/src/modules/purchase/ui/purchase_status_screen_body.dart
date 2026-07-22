import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/purchase/ui_widgets/int_ext.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_pagination_notifier.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
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
                : "Transaction Declined!",
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
                    Text("Amount"),
                    Text(
                      "NGN ${state.baseappAmount.formatAmount()}",
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
              ],
            ),
          ),
          10.spaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PurchaseStatusScreenButton(
                  title: 'Print Receipt',
                  bgColor: Color(0xff002766),
                  textColor: AppColors.rexWhite,
                  onTap: () {
                    ref
                        .read(posCardPurchaseProvider.notifier)
                        .doPrinting(copyType: 'MERCHANT COPY');
                  },
                ),
              ),
              SizedBox(width: 8.aw),
              Expanded(
                child: PurchaseStatusScreenButton(
                  title: 'Back Home',
                  bgColor: Color(0xffE8EEFF),
                  textColor: Color(0xff002766),
                  onTap: () {
                    ref.invalidate(posPaginationProvider);
                    ref.read(posCardPurchaseProvider.notifier).clearState();
                    if (state.isQuickPurchase) {
                      context.go(Routes.homeScreen);
                    } else {
                      context.go(Routes.dashboardHome);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PurchaseStatusScreenButton extends StatelessWidget {
  const PurchaseStatusScreenButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85.ah,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
