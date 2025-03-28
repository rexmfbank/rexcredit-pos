import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class RegisterMiddleNameField extends HookConsumerWidget {
  const RegisterMiddleNameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return RexTextField(
      outerTitle: 'Middle name',
      hintText: 'Enter your middle name',
      controller: provider.middleNameController,
      obscureText: false,
      showOuterTile: true,
      validator: (value) => TextfieldValidator.name(value),
    );
  }
}
