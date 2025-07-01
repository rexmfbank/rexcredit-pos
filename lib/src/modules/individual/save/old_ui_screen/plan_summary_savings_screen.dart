import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/fund_plan_bottom_sheet.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PlanSummarySavingsScreen extends ConsumerWidget {
  const PlanSummarySavingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.watch(loggerProvider);

    bool isSavingsPlanCreated = false;
    int savingsPlanId = 0;

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.savingsPlanTitle,
        subtitle: StringAssets.savingsPlanSubtitle,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          // PlanSummaryCardLayout(
          //   amountToSave: addNairaCurrencySymbol(planSummaryData.amountToSave!),
          //   targetAmount: addNairaCurrencySymbol(planSummaryData.targetAmount!),
          //   wht: '${planSummaryData.witholdingTax!}%',
          //   interestAmount:
          //       addNairaCurrencySymbol(planSummaryData.interestToBeEarned!),
          //   interestRate: '${planSummaryData.rate!}%',
          //   payoutAmount:
          //       addNairaCurrencySymbol(planSummaryData.totalAmountExpected!),
          //   maturityDate: planSummaryData.maturityDate!,
          //   savingsTenor: planSummaryData.noOfTimeToSave!,
          //   frequency: planSummaryData.frequency!,
          //   autosave: planSummaryData.autoSave == true ? 'Yes' : 'No',
          // ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {
                num amountToPay = 0;
                logger.d("Amount to pay: $amountToPay");

                final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
                var encodedImageString = "";

                showFundPlanBottomSheet(
                  context: context,
                  amountToPay: amountToPay.toDouble(),
                  isTopUp: false,
                  id: savingsPlanId,
                );
              },
              buttonTitle: StringAssets.fundSavingsPlanTextOnButton,
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
