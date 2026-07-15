import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class LoginScreenPassword extends ConsumerStatefulWidget {
  const LoginScreenPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginScreenPasswordState();
}

class _LoginScreenPasswordState extends ConsumerState<LoginScreenPassword> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(loginProvider);
    return RexTextFieldPassword(
      outerTitle: Strings.loginUserPasswordText1,
      hintText: Strings.passwordHint,
      controller: provider.passwordController,
      suffixOuterTitle: null,
      onTapSuffixOuterTitle: null,
    );
  }
}
