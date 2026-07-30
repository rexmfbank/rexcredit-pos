// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  () => ForgotPasswordNotifier(),
);

class ForgotPasswordNotifier extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() {
    ref.onDispose(() => _dispose());
    return ForgotPasswordState(
      isLoading: false,
      email: TextEditingController(),
      otp: TextEditingController(),
      newPasscode: TextEditingController(),
      confirmPasscode: TextEditingController(),
    );
  }

  void _dispose() {
    state.email.dispose();
    state.otp.dispose();
    state.newPasscode.dispose();
    state.confirmPasscode.dispose();
  }

  HeaderNoAuthNoCrypt _buildHeader() {
    final config = AppKeysStorage.getConfig();
    return HeaderNoAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
  }

  Future<void> sendOtp(BuildContext context) async {
    final email = state.email.text.trim();
    if (email.isBlank) {
      context.showSnack(message: 'Please enter your email address');
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.sendOtp(
        header: _buildHeader(),
        request: SendOtpRequest(email: email),
      );
      state = state.copyWith(isLoading: false);
      context.push(Routes.resetPasscode);
    } catch (err) {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: '$err');
    }
  }

  Future<void> resetPasscode(BuildContext context) async {
    final otp = state.otp.text.trim();
    final newPasscode = state.newPasscode.text.trim();
    final confirmPasscode = state.confirmPasscode.text.trim();

    if (otp.isBlank || newPasscode.isBlank || confirmPasscode.isBlank) {
      context.showSnack(message: 'Please fill all fields');
      return;
    }
    if (otp.length != 6) {
      context.showSnack(message: 'Passcode must be 6 digits');
      return;
    }
    if (newPasscode.length != 6 || confirmPasscode.length != 6) {
      context.showSnack(message: 'New passcode must be 6 digits');
      return;
    }
    if (newPasscode != confirmPasscode) {
      context.showSnack(message: 'Passcodes do not match');
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.resetPassword(
        header: _buildHeader(),
        request: ResetPasswordRequest(
          email: state.email.text.trim(),
          otp: otp,
          password: newPasscode,
          passwordConfirmation: confirmPasscode,
        ),
      );
      state.otp.clear();
      state.newPasscode.clear();
      state.confirmPasscode.clear();
      state = state.copyWith(isLoading: false);
      context.showSnack(message: 'Passcode reset successfully');
      context.go(Routes.login);
    } catch (err) {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: '$err');
    }
  }
}
