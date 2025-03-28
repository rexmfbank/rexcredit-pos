import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class DepositReasonTextField extends ConsumerWidget {
  const DepositReasonTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(fixedDepositProvider);

    return RexTextField(
      controller: savingState.planNameController,
      obscureText: false,
      showOuterTile: true,
      outerTitle: 'Fixed deposit name',
      inputType: TextInputType.text,
      validator: (value) => TextfieldValidator.input(value),
      textFieldIsRequired: true,
    );
  }
}
