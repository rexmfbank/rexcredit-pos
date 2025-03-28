import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreenEmail extends HookConsumerWidget {
  const LoginScreenEmail({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    //
    return RexTextField(
      outerTitle: StringAssets.emailAddressTitle,
      hintText: StringAssets.emptyString,
      controller: emailController,
      obscureText: false,
      showOuterTile: true,
      validator: (value) => TextfieldValidator.email(value),
    );
  }
}
