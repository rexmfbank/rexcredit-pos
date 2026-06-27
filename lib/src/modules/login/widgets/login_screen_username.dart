import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_text_validator.dart';
import 'package:rex_app/src/shared/widgets/rex_text_field.dart';

class LoginScreenUsername extends ConsumerWidget {
  const LoginScreenUsername({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loginProvider);
    //
    return RexTextField(
      outerTitle: "Email",
      hintText: "Enter Email",
      controller: provider.emailController,
      obscureText: false,
      showOuterTile: true,
      maxLines: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => AppTextValidator.businessName(value),
    );
  }
}
