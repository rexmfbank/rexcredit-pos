import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/forgot_password/provider/forgot_password_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  () => ForgotPasswordNotifier(),
);

class ForgotPasswordNotifier extends Notifier<ForgotPasswordState> {
  static const _resendCooldownSeconds = 120;

  Timer? _resendTimer;

  @override
  ForgotPasswordState build() {
    ref.onDispose(() => _dispose());
    return ForgotPasswordState(
      isLoading: false,
      email: TextEditingController(),
      otp: TextEditingController(),
      newPasscode: TextEditingController(),
      confirmPasscode: TextEditingController(),
      resendCountdown: 0,
      msgError: '',
      msgSuccess: '',
      event: ForgotPasswordEvent.none,
    );
  }

  void _dispose() {
    _resendTimer?.cancel();
    state.email.dispose();
    state.otp.dispose();
    state.newPasscode.dispose();
    state.confirmPasscode.dispose();
  }

  void resetMessage() {
    state = state.copyWith(
      msgError: '',
      msgSuccess: '',
      event: ForgotPasswordEvent.none,
    );
  }

  void clearFields() {
    state.email.clear();
    clearPasscodeFields();
  }

  void clearPasscodeFields() {
    state.otp.clear();
    state.newPasscode.clear();
    state.confirmPasscode.clear();
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    state = state.copyWith(resendCountdown: _resendCooldownSeconds);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.resendCountdown - 1;
      state = state.copyWith(resendCountdown: remaining < 0 ? 0 : remaining);
      if (state.resendCountdown == 0) timer.cancel();
    });
  }

  void _stopResendCountdown() {
    _resendTimer?.cancel();
    _resendTimer = null;
    state = state.copyWith(resendCountdown: 0);
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

  Future<void> sendOtp() async {
    await _requestOtp(isResend: false);
  }

  Future<void> resendOtp() async {
    if (!state.canResendOtp) return;
    await _requestOtp(isResend: true);
  }

  void _trimController(TextEditingController controller) {
    final trimmed = controller.text.trim();
    if (controller.text != trimmed) {
      controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }
  }

  Future<void> _requestOtp({required bool isResend}) async {
    final failureEvent = isResend
        ? ForgotPasswordEvent.otpResendFailed
        : ForgotPasswordEvent.otpSendFailed;

    _trimController(state.email);
    final email = state.email.text;
    if (email.isBlank) {
      state = state.copyWith(
        msgError: 'Please enter your email address',
        msgSuccess: '',
        event: failureEvent,
      );
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.sendOtp(
        header: _buildHeader(),
        request: SendOtpRequest(email: email),
      );
      _startResendCountdown();
      state = state.copyWith(
        isLoading: false,
        msgSuccess: 'An OTP has been sent to $email',
        msgError: '',
        event: isResend
            ? ForgotPasswordEvent.otpResent
            : ForgotPasswordEvent.otpSent,
      );
    } catch (e, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        msgSuccess: '',
        event: failureEvent,
      );
    }
  }

  Future<void> resetPasscode() async {
    _trimController(state.email);
    _trimController(state.otp);
    _trimController(state.newPasscode);
    _trimController(state.confirmPasscode);

    final otp = state.otp.text;
    final newPasscode = state.newPasscode.text;
    final confirmPasscode = state.confirmPasscode.text;

    if (otp.isBlank || newPasscode.isBlank || confirmPasscode.isBlank) {
      _setValidationError('Please fill all fields');
      return;
    }
    if (otp.length != 6) {
      _setValidationError('OTP must be 6 digits');
      return;
    }
    if (newPasscode.length != 6 || confirmPasscode.length != 6) {
      _setValidationError('New passcode must be 6 digits');
      return;
    }
    if (newPasscode != confirmPasscode) {
      _setValidationError('Passcodes do not match');
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.resetPassword(
        header: _buildHeader(),
        request: ResetPasswordRequest(
          email: state.email.text,
          otp: otp,
          password: newPasscode,
          passwordConfirmation: confirmPasscode,
        ),
      );
      _stopResendCountdown();
      state = state.copyWith(
        isLoading: false,
        msgSuccess: 'Passcode reset successfully',
        msgError: '',
        event: ForgotPasswordEvent.passcodeReset,
      );
    } catch (e, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        msgSuccess: '',
        event: ForgotPasswordEvent.passcodeResetFailed,
      );
    }
  }

  void _setValidationError(String message) {
    state = state.copyWith(
      msgError: message,
      msgSuccess: '',
      event: ForgotPasswordEvent.passcodeResetFailed,
    );
  }
}
