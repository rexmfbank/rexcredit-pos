import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/login/verify_location/provider/verify_location_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final verifyLocationProvider =
    NotifierProvider<VerifyLocationNotifier, VerifyLocationState>(
      () => VerifyLocationNotifier(),
    );

class VerifyLocationNotifier extends Notifier<VerifyLocationState> {
  @override
  VerifyLocationState build() {
    ref.onDispose(() => _dispose());
    return VerifyLocationState(
      isLoading: false,
      otp: TextEditingController(),
      msgError: '',
      event: VerifyLocationEvent.none,
    );
  }

  void _dispose() {
    state.otp.dispose();
  }

  void resetMessage() {
    state = state.copyWith(msgError: '', event: VerifyLocationEvent.none);
  }

  void clearFields() {
    state.otp.clear();
  }

  Future<void> verify() async {
    final otp = state.otp.text.trim();
    if (otp.isBlank) {
      _setError('Please enter the OTP sent to you');
      return;
    }
    if (otp.length != 6) {
      _setError('OTP must be 6 digits');
      return;
    }

    final config = AppKeysStorage.getConfig();
    final loginNotifier = ref.read(loginProvider.notifier);
    final header = HeaderNoAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );

    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.verifyLocationOtp(
        header: header,
        request: VerifyLocationOtpRequest(
          otp: otp,
          otpToken: loginNotifier.locationOtpToken,
        ),
      );
    } catch (e, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        event: VerifyLocationEvent.failed,
      );
      return;
    }

    // The location is trusted now, so the interrupted login is replayed to
    // build the session from a complete login response.
    final loginError = await loginNotifier.loginAfterLocationVerification();
    if (loginError != null) {
      state = state.copyWith(
        isLoading: false,
        msgError: loginError,
        event: VerifyLocationEvent.failed,
      );
      return;
    }
    state = state.copyWith(
      isLoading: false,
      msgError: '',
      event: VerifyLocationEvent.verified,
    );
  }

  void _setError(String message) {
    state = state.copyWith(
      msgError: message,
      event: VerifyLocationEvent.failed,
    );
  }
}
