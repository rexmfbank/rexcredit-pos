import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginScreenUsername extends ConsumerWidget {
  const LoginScreenUsername({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loginProvider);
    //
    return RexTextField(
      outerTitle: StringAssets.usernameText,
      hintText: StringAssets.usernameText2,
      controller: provider.usernameController,
      obscureText: false,
      showOuterTile: true,
      maxLines: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => TextfieldValidator.businessName(value),
    );
  }
}
