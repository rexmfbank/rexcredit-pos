import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SavingAmountTextField extends ConsumerWidget {
  const SavingAmountTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return RexTextField(
      prefixIcon: const RexTextFieldCurrencyWidget(),
      outerTitle: StringAssets.savingsInput,
      hintText: StringAssets.savingsPlanTargetAmountHint,
      controller: savingState.targetAmountController,
      obscureText: false,
      hasInputFormat: true,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      showOuterTile: true,
      validator: (value) => TextfieldValidator.savingsAmount2(value),
      textFieldIsRequired: true,
    );
  }
}
