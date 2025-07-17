import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/currency.dart';

void showWithdrawalSuccessfulModal(
  BuildContext context,
  int id,
  String depositAmount,
) {
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
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Withdrawal Successful',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.rexPurpleDark,
                            ),
                          ),
                          Flexible(
                            child: Image.asset(
                              AssetPath.fundSavingsSuccessIcon,
                              width: 64,
                              height: 64,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Text(
                          'Your Rex account has been credited with your savings balance',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.rexTint500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: AppColors.rexBackground,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                                top: 24.0,
                              ),
                              child: Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.rexPurpleDark,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: Text(
                                addNairaCurrencySymbol(depositAmount),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.rexPurpleDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RexFlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        buttonTitle: 'Close',
                        textColor: AppColors.rexPurpleDark,
                        backgroundColor: AppColors.rexBackground,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
