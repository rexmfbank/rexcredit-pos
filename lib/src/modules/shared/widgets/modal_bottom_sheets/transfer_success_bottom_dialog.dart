import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/screens/receipt_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/navigation.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showTransferSuccessModal(
  BuildContext context,
  String title,
  String subtitle, {
  required TransferData transInfo,
  required VoidCallback onPressed,
  String? buttonText,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Consumer(builder: (
        BuildContext context,
        WidgetRef ref,
        Widget? child,
      ) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 90,
                //   child: Lottie.asset(LottieAsset.successTick),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexTint500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.pushSuper(
                      TransferReceiptScreen(receiptData: transInfo),
                    );
                  },
                  child: const Text(
                    StringAssets.viewReceipts,
                    style: TextStyle(
                        color: AppColors.rexPurpleDark,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 12),
                RexFlatButton(
                  onPressed: onPressed,
                  buttonTitle: buttonText ?? StringAssets.ok,
                  textColor: AppColors.rexWhite,
                  backgroundColor: AppColors.rexPurpleLight,
                )
              ],
            ),
          ),
        );
      });
    },
  );
}
