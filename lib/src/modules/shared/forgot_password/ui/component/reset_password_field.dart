import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/forgot_password/provider/reset_password_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ResetPasswordField extends ConsumerWidget {
  const ResetPasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetPasswordProvider);
    return RexTextFieldPassword(
      outerTitle: StringAssets.changePasswordText2,
      hintText: StringAssets.changePasswordText4,
      controller: provider.passwordController,
      validator: (value) => TextfieldValidator.password(value),
    );
  }
}
