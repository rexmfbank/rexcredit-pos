import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';

class RegisterPasswordField extends HookConsumerWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return RexTextFieldPassword(
      outerTitle: 'Password',
      hintText: '',
      controller: provider.passwordController,
      textFieldIsRequired: true,
      validator: (value) => TextfieldValidator.password(value),
    );
  }
}
