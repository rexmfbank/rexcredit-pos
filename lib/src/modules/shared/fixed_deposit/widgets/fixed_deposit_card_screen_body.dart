import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/fund_deposit_card_layout.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class FixedDepositCardScreenBody extends ConsumerWidget {
  const FixedDepositCardScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const FundDepositCardLayout(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: RexFlatButton(
            onPressed: () => ref
                .watch(fixedDepositProvider.notifier)
                .validateFundDepositByCard(context),
            buttonTitle: StringAssets.fundSavingBtnTitle,
            backgroundColor: null,
          ),
        ),
      ],
    );
  }
}
