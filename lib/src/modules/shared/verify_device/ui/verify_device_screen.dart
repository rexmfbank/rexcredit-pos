import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_explanation_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/ui/component/otp_timer_widget.dart';
import 'package:rex_app/src/modules/shared/verify_device/providers/verify_device_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class VerifyDeviceScreen extends ConsumerWidget {
  const VerifyDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyDeviceState = ref.watch(verifyDeviceProvider);
    return Scaffold(
      appBar: const RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: false,
        title: StringAssets.verifyDeviceTitle2,
        subtitle: StringAssets.verifyAccountSubTitle,
      ),
      body: ListView(
        children: [
          const OtpExplanationText(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: RexTextField(
              outerTitle: StringAssets.otpTitle,
              hintText: StringAssets.otpHint,
              controller: verifyDeviceState.otpController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.number,
              maxLength: 6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexElevatedButton(
              onPressed: () {
                ref
                    .read(verifyDeviceProvider.notifier)
                    .validateOtpField(context);
              },
              backgroundColor: null,
              buttonTitle: StringAssets.nextTextOnButton,
            ),
          ),
          const OtpTimerWidget(actionCode: kChangeDevice)
        ],
      ),
    );
  }
}
