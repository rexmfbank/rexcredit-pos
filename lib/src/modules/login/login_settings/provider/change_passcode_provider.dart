import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/login_settings/provider/change_passcode_state.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final changePasscodeProvider =
    AutoDisposeNotifierProvider<ChangePasscodeNotifier, ChangePasscodeState>(
  () => ChangePasscodeNotifier(),
);

class ChangePasscodeNotifier extends AutoDisposeNotifier<ChangePasscodeState> {
  @override
  ChangePasscodeState build() {
    ref.onDispose(() => _dispose());
    return ChangePasscodeState(
      isLoading: false,
      currentPasscode: TextEditingController(),
      newPasscode: TextEditingController(),
      confirmPasscode: TextEditingController(),
      msgError: '',
      msgSuccess: '',
      event: ChangePasscodeEvent.none,
    );
  }

  void _dispose() {
    state.currentPasscode.dispose();
    state.newPasscode.dispose();
    state.confirmPasscode.dispose();
  }

  void resetMessage() {
    state = state.copyWith(
      msgError: '',
      msgSuccess: '',
      event: ChangePasscodeEvent.none,
    );
  }

  void clearFields() {
    state.currentPasscode.clear();
    state.newPasscode.clear();
    state.confirmPasscode.clear();
  }

  void _stripWhitespace(TextEditingController controller) {
    final cleaned = controller.text.replaceAll(RegExp(r'\s'), '');
    if (controller.text != cleaned) {
      controller.value = TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: cleaned.length),
      );
    }
  }

  void _setValidationError(String message) {
    state = state.copyWith(
      msgError: message,
      msgSuccess: '',
      event: ChangePasscodeEvent.failed,
    );
  }

  HeaderWithAuthNoCrypt _buildHeader() {
    final config = AppKeysStorage.getConfig();
    return HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.loginAuthToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
  }

  Future<void> changePasscode() async {
    _stripWhitespace(state.currentPasscode);
    _stripWhitespace(state.newPasscode);
    _stripWhitespace(state.confirmPasscode);

    final current = state.currentPasscode.text;
    final next = state.newPasscode.text;
    final confirm = state.confirmPasscode.text;

    if (current.isBlank || next.isBlank || confirm.isBlank) {
      _setValidationError('Please fill all fields');
      return;
    }
    if (current.length != 6 || next.length != 6 || confirm.length != 6) {
      _setValidationError('Passcode must be 6 digits');
      return;
    }
    if (next != confirm) {
      _setValidationError('New passcodes do not match');
      return;
    }
    if (current == next) {
      _setValidationError('New passcode must be different from current passcode');
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      final message = await RexApi.instance.changePassword(
        header: _buildHeader(),
        request: ChangePasswordRequest(
          currentPassword: current,
          newPassword: next,
          newPasswordConfirmation: confirm,
        ),
      );
      state = state.copyWith(
        isLoading: false,
        msgSuccess: message.isNotBlank
            ? message
            : 'Passcode changed successfully',
        msgError: '',
        event: ChangePasscodeEvent.success,
      );
    } catch (e, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        msgSuccess: '',
        event: ChangePasscodeEvent.failed,
      );
    }
  }
}
