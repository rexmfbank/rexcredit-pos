import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/pay_with_card_widget.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/pay_with_rex_wallet.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

void showFundRegularSavingsBottomSheet({
  required BuildContext context,
  required double amountToPay,
  int? id,
  required bool isTopUp,
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
    builder: (context) {
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        double walletBalance = 0.0;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fund Plan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.rexPurpleDark,
                            ),
                          ),
                          Text(
                            'Choose a payment method',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.rexTint500),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Image.asset(AssetPath.closeCircularIcon)),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      PayWithRex(
                        isTopUp: isTopUp,
                        id: id!,
                        isLoading: false,
                        amountToPay: amountToPay,
                        nubanBalanceString: '',
                        hasSufficientBalance: amountToPay < walletBalance,
                      ),
                      const SizedBox(height: 16.0),
                      PayWithCard(
                        id: id,
                        isTopUp: isTopUp,
                        amountToPay: amountToPay,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
