import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class OtpResendButton extends ConsumerWidget {
  const OtpResendButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => ref
          .watch(otpVerificationProvider.notifier)
          .resendOtp(context: context),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xff6E7191),
      ),
      child: const Text(
        StringAssets.otpResend,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
