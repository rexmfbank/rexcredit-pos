import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/login_screen_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/utils/app_keys.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final dashboardHomePageViewIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final profilePageViewIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

// final userAcctBalanceProvider =
//     FutureProvider.autoDispose<InternalBalanceEnquiryResponse>((ref) async {
//       final authToken = AppKeysStorage.getConfig().loginAuthToken;
//       final userAcctNumber = AppKeysStorage.getConfig().loginNuban;
//       //
//       final res = await RexApi.instance.makeInternalBalanceEnquiry(
//         token: authToken,
//         request: InternalBalanceEnquiryRequest(
//           bankCode: 'RMB',
//           accountNumber: userAcctNumber,
//         ),
//       );
//       return res;
//     });

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
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      isLoading: false,
      passwordValidation: null,
    );
  }

  void _dispose() {
    state.emailController.dispose();
    state.passwordController.dispose();
  }

  void validate(BuildContext context) async {
    if (state.emailController.text.isNotBlank &&
        state.passwordController.text.isNotBlank) {
      login(context);
      return;
    }
    context.showSnack(message: 'Please fill all fields');
  }

  Future<void> login(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final config = AppKeysStorage.getConfig();
    final request = LoginRequest(
      email: state.emailController.text.trim(),
      password: state.passwordController.text.trim(),
    );
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
      );
      await AppKeysStorage.saveConfig(updateConfig);
      state = state.copyWith(isLoading: false);
      debugPrintDev("AFTER SUCCESSFUL LOGIN");
      debugPrintDev(AppKeysStorage.getConfig().toString());
      context.go(Routes.dashboardIndividual);
    } catch (err, _) {
      context.showSnack(message: '$err');
    }
  }
}
