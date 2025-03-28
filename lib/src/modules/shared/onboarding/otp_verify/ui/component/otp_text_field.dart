import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class OtpTextField extends ConsumerWidget {
  const OtpTextField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(otpVerificationProvider);
    //
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: RexTextField(
        outerTitle: StringAssets.otpTitle,
        hintText: StringAssets.otpHint,
        controller: provider.otpController,
        obscureText: false,
        showOuterTile: true,
        inputType: TextInputType.number,
        maxLength: 6,
      ),
    );
  }
}
