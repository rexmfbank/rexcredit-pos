import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/fund_target_saving_card_layout.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TargetSavingCardScreenBody extends ConsumerWidget {
  const TargetSavingCardScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const FundTargetSavingCardLayout(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RexFlatButton(
            onPressed: () => ref
                .watch(targetSavingProvider.notifier)
                .validateFundSavingByCard(context),
            buttonTitle: StringAssets.fundSavingBtnTitle,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
