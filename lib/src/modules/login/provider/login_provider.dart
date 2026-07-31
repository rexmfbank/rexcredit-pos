// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/login_screen_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

final hideBalanceProvider = StateProvider<bool>((ref) {
  // Initial state comes from the static local storage
  return AppKeysStorage.getConfig().loginHideAccount;
});

final loginProvider = NotifierProvider<LoginNotifier, LoginScreenState>(
  () => LoginNotifier(),
);

class LoginNotifier extends Notifier<LoginScreenState> {
  @override
  LoginScreenState build() {
    ref.onDispose(() => _dispose());
    return LoginScreenState(
      isLoading: false,
      passwordValidation: null,
      oneEmail: TextEditingController(),
      onePasscode: TextEditingController(),
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
    state = state.copyWith(msgError: '', msgSuccess: '');
  }

  void validate() {
    // The terminal is bound to a single account, so once an identifier has been
    // persisted the user only supplies the passcode.
    if (AppKeysStorage.getConfig().loginUsername.isNotBlank) {
      if (state.onePasscode.text.isNotBlank) {
        login();
        return;
      }
      state = state.copyWith(msgError: 'Please enter your passcode');
      return;
    }
    if (state.tabIndex == 0) {
      if (state.oneEmail.text.isNotBlank && state.onePasscode.text.isNotBlank) {
        login();
        return;
      }
    } else {
      if (state.twoPhone.text.isNotBlank && state.twoPasscode.text.isNotBlank) {
        login();
        return;
      }
    }
    state = state.copyWith(msgError: 'Please fill all fields');
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    // A persisted identifier is read from storage rather than from a
    // controller: clearFields() runs after every successful login while this
    // notifier stays alive, so the controllers are empty when the inactivity
    // timer sends the user back to the login screen.
    final hasSavedUsername = config.loginUsername.isNotBlank;
    final isEmailTab = state.tabIndex == 0;
    final username =
        hasSavedUsername
            ? config.loginUsername
            : isEmailTab
            ? state.oneEmail.text.trim()
            : state.twoPhone.text.trim();
    final passcode =
        hasSavedUsername || isEmailTab
            ? state.onePasscode.text.trim()
            : state.twoPasscode.text.trim();
    //
    final request = LoginRequest(email: username, password: passcode);
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
      state = state.copyWith(
        isLoading: false,
        msgSuccess: 'Login successful',
        msgError: '',
      );
      debugPrintDev("AFTER SUCCESSFUL LOGIN");
      debugPrintDev(AppKeysStorage.getConfig().toString());
    } catch (e, _) {
      state = state.copyWith(
        isLoading: false,
        msgError: e.toString(),
        msgSuccess: '',
      );
    }
  }
}
