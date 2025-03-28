import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/regular_savings_summary_card.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/show_fund_saving_sheet.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class TargetSavingSummaryScreenBody extends ConsumerWidget {
  const TargetSavingSummaryScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return ListView(
      children: [
        const SizedBox(height: 32),
        RegularSavingsSummaryCard(
          savingsAmount:
              savingState.savingsReturn.targetAmount.formatCurrencyNum(),
          amountToSave: savingState.savingsReturn.recurringAmountToSave
              .formatCurrencyString(),
          interestRate: "${savingState.savingsReturn.rate}%",
          savingsTenor: savingState.savingsReturn.duration,
          frequency: savingState.savingsReturn.frequency,
          autosave: savingState.savingsReturn.autoSave == 'Y' ? 'Yes' : 'No',
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RexFlatButton(
            onPressed: () {
              showFundSavingSheet(context: context);
            },
            buttonTitle: StringAssets.fundRegularSavingsPlanTextOnButton,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
