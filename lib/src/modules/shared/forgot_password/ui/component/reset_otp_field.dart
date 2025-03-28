import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/forgot_password/provider/reset_password_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class ResetOtpField extends ConsumerWidget {
  const ResetOtpField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetPasswordProvider);
    return RexTextField(
      hintText: 'OTP Code',
      controller: provider.otpController,
      obscureText: false,
      showOuterTile: true,
      inputType: TextInputType.number,
      maxLines: 1,
      outerTitle: 'Enter OTP code sent to phone/email',
    );
  }
}
