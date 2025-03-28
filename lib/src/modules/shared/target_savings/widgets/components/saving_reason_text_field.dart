import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class SavingReasonTextField extends ConsumerWidget {
  const SavingReasonTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savingState = ref.watch(targetSavingProvider);

    return RexTextField(
      controller: savingState.planNameController,
      obscureText: false,
      showOuterTile: true,
      outerTitle: 'Reason for saving',
      inputType: TextInputType.text,
      validator: (value) => TextfieldValidator.input(value),
      textFieldIsRequired: true,
    );
  }
}
