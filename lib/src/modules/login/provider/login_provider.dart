// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/login_screen_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

final profilePageViewIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

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
      oneEmail: TextEditingController(text: 'akenwood@yopmail.com'),
      onePasscode: TextEditingController(text: '123456'),
      twoPhone: TextEditingController(),
      twoPasscode: TextEditingController(),
      tabIndex: 0,
    );
  }

  void _dispose() {
    state.oneEmail.dispose();
    state.onePasscode.dispose();
    state.twoPhone.dispose();
    state.twoPasscode.dispose();
  }

  void setSelectedTab(int index) {
    state = state.copyWith(tabIndex: index);
  }

  void validate(BuildContext context) {
    if (state.tabIndex == 0) {
      if (state.oneEmail.text.isNotBlank && state.onePasscode.text.isNotBlank) {
        login(context);
        return;
      }
    } else {
      if (state.twoPhone.text.isNotBlank && state.twoPasscode.text.isNotBlank) {
        login(context);
        return;
      }
    }
    context.showSnack(message: 'Please fill all fields');
  }

  Future<void> login(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    //
    final request =
        state.tabIndex == 0
            ? LoginRequest(
              email: state.oneEmail.text.trim(),
              password: state.onePasscode.text.trim(),
            )
            : LoginRequest(
              email: state.twoPhone.text.trim(),
              password: state.twoPasscode.text.trim(),
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
      );
      await AppKeysStorage.saveConfig(updateConfig);
      state = state.copyWith(isLoading: false);
      debugPrintDev("AFTER SUCCESSFUL LOGIN");
      debugPrintDev(AppKeysStorage.getConfig().toString());
      context.go(Routes.loginHome);
    } catch (err, _) {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: '$err');
    }
  }
}
