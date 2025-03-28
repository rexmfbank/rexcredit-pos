import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_timer_widget.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_explanation_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_text_field.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_verify_screen_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpVerifyScreen extends HookConsumerWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: false,
        title: StringAssets.otpScreenTitle,
        subtitle: StringAssets.verifyAccountSubTitle,
      ),
      body: Column(
        children: [
          OtpExplanationText(),
          OtpTextField(),
          OtpVerifyScreenButton(),
          OtpTimerWidget(),
        ],
      ),
    );
  }
}
