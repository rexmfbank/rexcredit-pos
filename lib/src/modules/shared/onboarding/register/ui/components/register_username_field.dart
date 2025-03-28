import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterUsernameField extends HookConsumerWidget {
  const RegisterUsernameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(registerProvider);
    //
    return RexTextField(
      outerTitle: StringAssets.usernameText,
      showOuterTile: true,
      hintText: StringAssets.usernameText3,
      controller: provider.usernameController,
      obscureText: false,
      maxLines: 1,
      textFieldIsRequired: true,
      validator: (value) => TextfieldValidator.businessName(value),
    );
  }
}
