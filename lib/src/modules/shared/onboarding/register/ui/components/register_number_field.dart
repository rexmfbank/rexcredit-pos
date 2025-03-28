import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterNumberField extends HookConsumerWidget {
  const RegisterNumberField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return RexTextField(
      outerTitle: StringAssets.phoneNumberTitle,
      hintText: StringAssets.phoneNumberHint,
      controller: provider.phoneController,
      obscureText: false,
      showOuterTile: true,
      maxLength: 11,
      inputType: TextInputType.number,
      textFieldIsRequired: true,
      validator: (value) => TextfieldValidator.phoneNumber(value),
    );
  }
}
