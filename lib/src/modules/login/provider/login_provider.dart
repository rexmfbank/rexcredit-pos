// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/dio/api_response.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/login_screen_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_regex.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

final hideBalanceProvider = StateProvider<bool>((ref) {
  // Initial state comes from the static local storage
  return AppKeysStorage.getConfig().loginHideAccount;
});

final loginProvider = NotifierProvider<LoginNotifier, LoginScreenState>(
  () => LoginNotifier(),
);

class LoginNotifier extends Notifier<LoginScreenState> {
  /// Credentials of the attempt that asked for location verification. They are
  /// replayed once the OTP has been accepted so the session is created from a
  /// full login response rather than from the verification response alone.
  String _pendingUsername = '';
  String _pendingPasscode = '';
  String _pendingOtpToken = '';
  String _pendingOtpMessage = '';

  /// Identifies the pending verification to the verify-location-otp endpoint.
  String get locationOtpToken => _pendingOtpToken;

  /// The backend's own wording for why verification is needed, shown on the
  /// verification screen when present.
  String get locationOtpMessage => _pendingOtpMessage;

  @override
  LoginScreenState build() {
    ref.onDispose(() => _dispose());
    return LoginScreenState(
      isLoading: false,
      passwordValidation: null,
      oneEmail: TextEditingController(text: 'Ifypos1@yopmail.com'),
      onePasscode: TextEditingController(text: "123456"),
      twoPhone: TextEditingController(),
      twoPasscode: TextEditingController(),
      tabIndex: 0,
      msgError: '',
      msgSuccess: '',
    );
  }

  void _dispose() {
    state.oneEmail.dispose();
    state.onePasscode.dispose();
    state.twoPhone.dispose();
    state.twoPasscode.dispose();
  }

  void clearFields() {
    state.oneEmail.clear();
    state.onePasscode.clear();
    state.twoPhone.clear();
    state.twoPasscode.clear();
  }

  void setSelectedTab(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void resetMessage() {
    state = state.copyWith(
      msgError: '',
      msgSuccess: '',
      event: LoginEvent.none,
    );
  }

  void validate() {
    _trimLoginFields();
    // The terminal is bound to a single account, so once an identifier has been
    // persisted the user only supplies the passcode.
    if (AppKeysStorage.getConfig().loginUsername.isNotBlank) {
      if (state.onePasscode.text.isNotBlank) {
        login();
        return;
      }
      _setValidationError('Please enter your passcode');
      return;
    }
    if (state.tabIndex == 0) {
      if (state.oneEmail.text.isBlank || state.onePasscode.text.isBlank) {
        _setValidationError('Please fill all fields');
        return;
      }
      if (!_isValidEmail(state.oneEmail.text)) {
        _setValidationError('Please enter a valid email address');
        return;
      }
      login();
      return;
    }
    if (state.twoPhone.text.isNotBlank && state.twoPasscode.text.isNotBlank) {
      login();
      return;
    }
    _setValidationError('Please fill all fields');
  }

  bool _isValidEmail(String value) {
    return RegExp(StringRegex.email).hasMatch(value);
  }

  void _setValidationError(String message) {
    state = state.copyWith(
      msgError: message,
      msgSuccess: '',
      event: LoginEvent.failed,
    );
  }

  Future<void> login() async {
    final config = AppKeysStorage.getConfig();
    // A persisted identifier is read from storage rather than from a
    // controller: clearFields() runs after every successful login while this
    // notifier stays alive, so the controllers are empty when the inactivity
    // timer sends the user back to the login screen.
    final hasSavedUsername = config.loginUsername.isNotBlank;
    final isEmailTab = state.tabIndex == 0;
    _trimLoginFields();
    final username =
        hasSavedUsername
            ? config.loginUsername.trim()
            : isEmailTab
            ? state.oneEmail.text
            : state.twoPhone.text;
    final passcode =
        hasSavedUsername || isEmailTab
            ? state.onePasscode.text
            : state.twoPasscode.text;
    //
    await _submitLogin(username: username, passcode: passcode);
  }

  /// Strips accidental whitespace from login fields before validation/submit.
  /// Passcode/phone controllers drop every whitespace char; email only trims.
  void _trimLoginFields() {
    _sanitizeController(state.oneEmail, stripInternalWhitespace: false);
    _sanitizeController(state.onePasscode, stripInternalWhitespace: true);
    _sanitizeController(state.twoPhone, stripInternalWhitespace: true);
    _sanitizeController(state.twoPasscode, stripInternalWhitespace: true);
  }

  void _sanitizeController(
    TextEditingController controller, {
    required bool stripInternalWhitespace,
  }) {
    final cleaned = stripInternalWhitespace
        ? controller.text.replaceAll(RegExp(r'\s'), '')
        : controller.text.trim();
    if (controller.text != cleaned) {
      controller.value = TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: cleaned.length),
      );
    }
  }

  /// Replays the login that was interrupted by location verification, so the
  /// session is built from a full login response. Returns an error message on
  /// failure instead of publishing an event, because the verification screen —
  /// not the login screen underneath it — owns that outcome.
  Future<String?> loginAfterLocationVerification() async {
    if (_pendingUsername.isBlank || _pendingPasscode.isBlank) {
      return 'Your login session has expired. Please log in again.';
    }
    return _submitLogin(
      username: _pendingUsername,
      passcode: _pendingPasscode,
      isRetryAfterVerification: true,
    );
  }

  Future<String?> _submitLogin({
    required String username,
    required String passcode,
    bool isRetryAfterVerification = false,
  }) async {
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    //
    final request = LoginRequest.fromIdentifier(
      identifier: username,
      password: passcode,
    );
    //
    final header = HeaderNoAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    //
    try {
      final res = await RexApi.instance.login(request: request, header: header);
      final updateConfig = config.copyWith(
        loginAuthToken: res.accessToken,
        borrowerID: res.borrowerId,
        loginFullname: "${res.firstName} ${res.lastName}",
        loginFirstname: res.firstName,
        loginUsername: username,
      );
      await AppKeysStorage.saveConfig(updateConfig);
      _clearPendingCredentials();
      state = state.copyWith(
        isLoading: false,
        msgSuccess: 'Login successful',
        msgError: '',
        event: isRetryAfterVerification ? LoginEvent.none : LoginEvent.success,
      );
      debugPrintDev("AFTER SUCCESSFUL LOGIN");
      debugPrintDev(AppKeysStorage.getConfig().toString());
      return null;
    } on LocationOtpRequiredException catch (e) {
      // Being asked to verify again right after a successful verification would
      // bounce the user back to the OTP screen, so it is reported as a failure.
      if (isRetryAfterVerification) {
        state = state.copyWith(isLoading: false);
        return e.toString();
      }
      _pendingUsername = username;
      _pendingPasscode = passcode;
      _pendingOtpToken = e.otpToken;
      _pendingOtpMessage = e.message.toString();
      state = state.copyWith(
        isLoading: false,
        msgError: '',
        msgSuccess: '',
        event: LoginEvent.locationOtpRequired,
      );
      return e.toString();
    } catch (e, _) {
      if (isRetryAfterVerification) {
        state = state.copyWith(isLoading: false);
        return e.toString();
      }
      _clearPendingCredentials();
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        msgSuccess: '',
        event: LoginEvent.failed,
      );
      return e.toString();
    }
  }

  void _clearPendingCredentials() {
    _pendingUsername = '';
    _pendingPasscode = '';
    _pendingOtpToken = '';
    _pendingOtpMessage = '';
  }
}
