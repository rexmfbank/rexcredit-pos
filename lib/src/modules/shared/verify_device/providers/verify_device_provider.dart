// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/verify_device/model/verify_device_state.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final verifyDeviceProvider =
    AutoDisposeNotifierProvider<VerifyDeviceNotifier, VerifyDeviceState>(
        VerifyDeviceNotifier.new);

class VerifyDeviceNotifier extends AutoDisposeNotifier<VerifyDeviceState> {
  DeviceMetaData? meta;

  @override
  VerifyDeviceState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return VerifyDeviceState(otpController: TextEditingController());
  }

  void validateOtpField(BuildContext context) {
    if (state.otpController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: StringAssets.enterOtpTitle,
      );
    } else {
      verifyNewDevice(context);
    }
  }

  Future<void> verifyNewDevice(BuildContext context) async {
    final username = ref.watch(usernameProvider);
    //
    final request = VerifyNewDeviceRequest(
      username: username,
      mobileNumber: '',
      otp: state.otpController.text,
      entityCode: '',
      deviceId: meta?.deviceNumber ?? '',
      actionCode: kChangeDevice,
    );
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.verifyNewDevice(
          appVersion: ref.read(appVersionProvider), request: request);
      LoadingScreen.instance().hide();
      context.go(RouteName.login);
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> _checkForOnboardingCompletion(BuildContext context) async {
    final name = ref.watch(usernameProvider);
    final pass = ref.watch(userPassProvider);
    ref.read(loginProvider.notifier).login(context, username: name, pass: pass);
  }
}
