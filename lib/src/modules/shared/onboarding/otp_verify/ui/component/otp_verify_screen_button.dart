import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class OtpVerifyScreenButton extends ConsumerWidget {
  const OtpVerifyScreenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexElevatedButton(
      onPressed: () {
        ref.read(otpVerificationProvider.notifier).verifyOtp(context);
      },
      backgroundColor: null,
      buttonTitle: StringAssets.nextTextOnButton,
    );
  }
}
