import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/int_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class QuickPurchaseStatusScreen extends ConsumerWidget {
  const QuickPurchaseStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardPurchaseState = ref.watch(posCardPurchaseProvider);
    return AppScaffold(
      isLoading: cardPurchaseState.loadingApi,
      body: Padding(
        padding: EdgeInsets.all(12.ar),
        child: ListView(
          // padding: EdgeInsets.all(8.ar),
          children: [
            SizedBox(height: 20),
            cardPurchaseState.purchaseStatusCode == '00'
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.rexGreen,
                    size: 60,
                  )
                : Icon(
                    Icons.close,
                    color: AppColors.red,
                    size: 60,
                  ),
            20.spaceHeight(),
            Text(
              cardPurchaseState.purchaseStatusCode == '00'
                  ? "Transaction Approved!"
                  : "Transaction Declined",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            15.spaceHeight(),
            Container(
              margin: EdgeInsets.all(12.0),
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
                        cardPurchaseState.transactionResponse.transactionType ??
                            'n/a',
                      )
                    ],
                  ),
                  SizedBox(height: 8.ah),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount"),
                      Text(
                          cardPurchaseState.transactionResponse.amount ?? 'n/a')
                    ],
                  ),
                  SizedBox(height: 8.ah),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transaction Status"),
                      Text(
                        cardPurchaseState.purchaseStatusCode == '00'
                            ? 'Successful'
                            : cardPurchaseState.transactionResponse.message ??
                                'n/a',
                      )
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
                    .printCardTransaction(context);
              },
              buttonTitle: 'Print Receipt',
            ),
            RexElevatedButton(
              backgroundColor: AppColors.rexTint400,
              // foregroundColor: AppColors.rexBlack,
              onPressed: () {
                context.go(Routes.homeScreen);
              },
              buttonTitle: "Cancel",
            ),
          ],
        ),
      ),
    );
  }
}
