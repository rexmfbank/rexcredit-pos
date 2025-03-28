import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/initiate_reset_button.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/navigate_to_login_text.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/reset_password_header.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/initiate_reset_username_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class InitiateResetPasswordScreen extends ConsumerWidget {
  const InitiateResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.rexBackground,
      ),
      body: ListView(
        children: const [
          ResetPasswordHeader(text: StringAssets.resetPassword1),
          InitiateResetUsernameField(),
          InitiateResetButton(),
          NavigateToLoginText(),
        ],
      ),
    );
  }
}
