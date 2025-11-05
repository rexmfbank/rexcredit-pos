import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/navigate_to_login_text.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/reset_button.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/reset_otp_field.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/reset_password_field.dart';
import 'package:rex_app/src/modules/shared/forgot_password/ui/component/reset_password_header.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_timer_widget.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.rexBackground,
      ),
      body: ListView(
        children: const [
          ResetPasswordHeader(text: Strings.resetPassword2),
          ResetOtpField(),
          ResetPasswordField(),
          ResetButton(),
          OtpTimerWidget(),
          NavigateToLoginText(),
        ],
      ),
    );
  }
}
