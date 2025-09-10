import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field_password.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

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
      outerTitle: StringAssets.loginUserPasswordText1,
      hintText: StringAssets.passwordHint,
      controller: provider.passwordController,
      suffixOuterTitle: StringAssets.loginUserPasswordText2,
      onTapSuffixOuterTitle: () {
        context.push(Routes.initiateResetPassword);
      },
    );
  }
}
