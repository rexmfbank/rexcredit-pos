import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fixed_deposit_summary_card.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/show_fund_deposit_sheet.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class FixedDepositSummaryScreenBody extends ConsumerWidget {
  const FixedDepositSummaryScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(fixedDepositProvider);

    return ListView(
      children: [
        const SizedBox(height: 32),
        FixedDepositSummaryCard(
          depositData: savingState.depositInterestRateData,
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RexFlatButton(
            onPressed: () {
              showFundDepositSheet(
                context: context,
              );
            },
            buttonTitle: StringAssets.fundRegularSavingsPlanTextOnButton,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
