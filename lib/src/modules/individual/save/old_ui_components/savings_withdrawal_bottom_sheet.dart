import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_withdrawal_pin_bottom_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/currency.dart';

void showSavingsWithdrawModalSheet({
  required BuildContext context,
  required String balance,
  required int planId,
  required String maturityDate,
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
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Withdraw Savings",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                      child: Text(
                        "You are attempting to make a withdrawal before your maturity date",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(110, 113, 145, 1),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.rexBackground,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0, top: 24.0),
                            child: Text(
                              "Savings Plan Balance",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.rexPurpleDark,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, top: 8.0),
                            child: Text(
                              addNairaCurrencySymbol(balance),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.rexPurpleDark,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey.withAlpha(100),
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, top: 4.0),
                            child: Text(
                              "Maturity Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.rexTint500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              top: 8.0,
                              bottom: 18,
                            ),
                            child: Text(
                              maturityDate,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.rexPurpleDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.rexBackground,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/png/caution_icon.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          const Flexible(
                            child: Text(
                              "This action cannot be reversed. You would be charged a preliquidation fee.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff4A5771),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: RexFlatButton(
                              onPressed: () {
                                showSavingsWithdrawPinModalSheet(
                                  context: context,
                                  planId: planId,
                                  balance: balance,
                                );
                              },
                              backgroundColor: const Color(0xffFFF0F2),
                              buttonTitle: "Proceed",
                              textColor: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 1,
                            child: RexFlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              buttonTitle: "Cancel withdrawal",
                              backgroundColor: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
