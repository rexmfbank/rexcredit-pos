import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/fund_plan_bottom_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/int_utils.dart';

void showSavingsTopUpModalSheet(
    {required BuildContext context, required int planId}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return HookConsumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final topUpSavingsPlanController = useTextEditingController();
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
                      child: Text(
                        'Top up savings plan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(AssetPath.closeCircularIcon)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Please enter your top up amount and select your preferred payment method.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(110, 113, 145, 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RexTextField(
                      outerTitle: 'Top up amount',
                      hintText: '100,000',
                      prefixIcon: const RexTextFieldCurrencyWidget(),
                      inputType: TextInputType.number,
                      controller: topUpSavingsPlanController,
                      obscureText: false,
                      backgroundColor: AppColors.rexBackground,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 4.0),
                            child: RexFlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: AppColors.rexPurpleDark,
                              buttonTitle: 'Close',
                              backgroundColor:
                                  const Color.fromARGB(230, 185, 210, 246),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 16.0),
                            child: RexFlatButton(
                              onPressed: () {
                                showFundPlanBottomSheet(
                                    context: context,
                                    amountToPay: parseInteger(
                                            topUpSavingsPlanController.text)
                                        .toDouble(),
                                    isTopUp: true,
                                    id: planId);
                              },
                              buttonTitle: 'Next',
                              backgroundColor: AppColors.rexPurpleDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
