import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/auto_save_checkbox.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/auto_save_widget.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/saving_amount_text_field.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/saving_deposit_amount_text_field.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/saving_duration_slider.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/saving_frequency_dropdown.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/saving_reason_text_field.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/start_saving_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TargetSavingStartScreenBody extends ConsumerWidget {
  const TargetSavingStartScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SavingReasonTextField(),
        const SavingAmountTextField(),
        const SavingDurationSlider(),
        const AutoSaveCheckbox(),
        savingState.isYesChecked == true ? const AutoSaveWidget() : Container(),
        const SizedBox(height: 8),
        const SavingFrequencyDropdown(),
        const SizedBox(height: 8),
        const SavingDepositAmountTextField(),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: savingState.isLoadingSavingsReturn
              ? const Text(StringAssets.calculateReturn)
              : Container(),
        ),
        const StartSavingButton(),
      ],
    );
  }
}
