import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterNINField extends ConsumerWidget {
  const RegisterNINField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    return RexTextField(
      outerTitle: StringAssets.ninTitleText,
      showOuterTile: true,
      hintText: StringAssets.ninHintText,
      controller: provider.ninController,
      obscureText: false,
      inputType: TextInputType.number,
      maxLength: 11,
      textFieldIsRequired: true,
      validator: (value) => TextfieldValidator.nin(value),
    );
  }
}
