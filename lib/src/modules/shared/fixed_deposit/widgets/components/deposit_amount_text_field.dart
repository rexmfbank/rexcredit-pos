import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/custom_text_field_currency_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DepositAmountTextField extends ConsumerWidget {
  const DepositAmountTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(fixedDepositProvider);

    return RexTextField(
      prefixIcon: const RexTextFieldCurrencyWidget(),
      outerTitle: StringAssets.investInput,
      hintText: StringAssets.savingsPlanTargetAmountHint,
      controller: savingState.amountController,
      obscureText: false,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      hasInputFormat: true,
      showOuterTile: true,
      validator: (value) =>
          TextfieldValidator.checkAmountInput(value, 100000.0),
      textFieldIsRequired: true,
    );
  }
}
