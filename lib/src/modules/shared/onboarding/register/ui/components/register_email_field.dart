import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterEmailField extends HookConsumerWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return RexTextField(
      outerTitle: StringAssets.emailAddressTitle,
      hintText: StringAssets.emailAddressHint,
      controller: provider.emailController,
      obscureText: false,
      showOuterTile: true,
      textFieldIsRequired: true,
      maxLines: 1,
      validator: (value) => TextfieldValidator.email(value),
    );
  }
}
