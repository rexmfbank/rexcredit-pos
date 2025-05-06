import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/app_config.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/more/profile/models/reset_transaction_pin_state.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final resetTransactionPinProvider = AutoDisposeNotifierProvider<
    ResetTransactionPinNotifier, ResetTransactionPinOtpState>(
  () => ResetTransactionPinNotifier(),
);

class ResetTransactionPinNotifier
    extends AutoDisposeNotifier<ResetTransactionPinOtpState> {
  @override
  ResetTransactionPinOtpState build() {
    return ResetTransactionPinOtpState(
      pinController: TextEditingController(),
      otpController: TextEditingController(),
    );
  }

  Future<void> initiateTransactionPinReset() async {
    state = state.copyWith(initiateResponse: const AsyncValue.loading());
    try {
      final apiResponse = await RexApi.instance.initiateTransactionPinReset(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        username: ref.watch(usernameProvider),
        entityCode:
            ref.read(loginProvider).loginResponse.value?.data.entityCode ??
                'RMB',
      );
      state = state.copyWith(initiateResponse: AsyncValue.data(apiResponse));
    } catch (error, stackTrace) {
      state =
          state.copyWith(initiateResponse: AsyncValue.error(error, stackTrace));
    }
  }

  Future<void> resetTransactionPin(BuildContext context, String pin) async {
    final username = ref.watch(usernameProvider);
    final request = ResetTransactionPinRequest(
      otp: state.otpController.text,
      mobileNumber: ref.watch(userPhoneNumberProvider),
      username: username,
      entityCode:
          ref.read(loginProvider).loginResponse.value?.data.entityCode ?? 'RMB',
      transactionPin: pin,
    );
    state = state.copyWith(resetResponse: const AsyncValue.loading());
    LoadingScreen.instance().show(context: context);
    try {
      final apiResponse = await RexApi.instance.resetTransactionPin(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(resetResponse: AsyncValue.data(apiResponse));
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.resetPassword3,
          isDismissible: false,
          onPressed: () {
            context.go(RouteName.dashboardMore);
          },
        );
      }
    } catch (error, stackTrace) {
      LoadingScreen.instance().hide();
      state =
          state.copyWith(resetResponse: AsyncValue.error(error, stackTrace));
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }
}
