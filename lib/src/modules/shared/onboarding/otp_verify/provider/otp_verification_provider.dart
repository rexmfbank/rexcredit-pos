// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/model/otp_screen_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

const kChangeDevice = "CHANGE_DEVICE";

final otpVerificationProvider =
    NotifierProvider<OtpVerificationNotifier, OtpScreenState>(
  () => OtpVerificationNotifier(),
);

class OtpVerificationNotifier extends Notifier<OtpScreenState> {
  DeviceMetaData? meta;

  @override
  OtpScreenState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return OtpScreenState(
      otpController: TextEditingController(),
    );
  }

  Future<void> verifyOtp(BuildContext context) async {
    if (state.otpController.text.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyOtp,
        title: StringAssets.emptyValueText,
      );
      return;
    }
    ref.invalidate(registerProvider);
    final username = ref.watch(usernameProvider);
    final mobileNumber = ref.watch(userPhoneNumberProvider);
    final entityCode = ref.watch(userEntityCodeProvider);

    //
    final request = VerifyOtpRequest(
      username: username,
      mobileNumber: mobileNumber,
      otp: state.otpController.text,
      entityCode: entityCode.isEmpty ? 'RMB' : entityCode,
      deviceId: meta?.deviceNumber ?? '',
    );
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.verifyOtp(
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      LoadingScreen.instance().hide();
      context.go(RouteName.accountType);
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> resendOtp({
    required BuildContext context,
    String? actionCode,
  }) async {
    final username = ref.watch(usernameProvider);

    try {
      await RexApi.instance.resendOtp(
        appVersion: ref.read(appVersionProvider),
        request: SendOtpRequest(
          username: username,
          actionCode: actionCode ?? '',
        ),
      );
      context.showToast(message: StringAssets.otpResend2);
    } catch (error) {
      context.showToast(message: StringAssets.otpResend3);
    }
  }
}
