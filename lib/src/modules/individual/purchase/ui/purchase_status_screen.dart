import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/individual/purchase/ui/components/int_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class PurchaseStatusScreen extends ConsumerWidget {
  const PurchaseStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posCardPurchaseState = ref.watch(posCardPurchaseProvider);
    return AppScaffold(
      isLoading: posCardPurchaseState.loadingApi,
      body: Padding(
        padding: EdgeInsets.all(16.ar),
        child: ListView(
          padding: EdgeInsets.all(16.ar),
          children: [
            SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.rexBlack,
                  width: 2.0,
                ),
              ),
              child: posCardPurchaseState.purchaseStatusCode == '00'
                  ? Icon(
                      Icons.check_circle,
                      color: AppColors.rexGreen,
                      size: 100,
                    )
                  : Icon(
                      Icons.close,
                      color: AppColors.red,
                      size: 100,
                    ),
            ),
            20.spaceHeight(),
            Text(
              posCardPurchaseState.purchaseStatusCode == '00'
                  ? "Transaction Approved"
                  : "Transaction Declined",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            30.spaceHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount"),
                Text(posCardPurchaseState.transactionResponse.amount ?? 'n/a')
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transaction Type"),
                Text(
                  posCardPurchaseState.transactionResponse.transactionType ??
                      'n/a',
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Message"),
                Text(posCardPurchaseState.transactionResponse.message ?? 'n/a'),
              ],
            ),
            RexElevatedButton(onPressed: () {}, buttonTitle: "Request Support"),
            RexElevatedButton(
              backgroundColor: AppColors.rexTint400,
              onPressed: () {
                ref
                    .read(posCardPurchaseProvider.notifier)
                    .savePurchaseToBackend(context);
              },
              buttonTitle: 'Back to home',
            ),
          ],
        ),
      ),
    );
  }
}
