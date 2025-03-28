import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_amount_text_field.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_duration_dropdown.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_interest_type_dropdown.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_rates.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_reason_text_field.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_start_button.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';

class FixedDepositStartScreenBody extends ConsumerWidget {
  const FixedDepositStartScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(fixedDepositProvider);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const DepositReasonTextField(),
        const DepositAmountTextField(),
        const DepositInterestTypeDropdown(),
        const DepositDurationDropdown(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: savingState.isLoadingSavingsReturn
              ? const Text('Calculating return')
              : Container(),
        ),
        const DepositStartButton(),
        //const DepositRates(),
      ],
    );
  }
}
