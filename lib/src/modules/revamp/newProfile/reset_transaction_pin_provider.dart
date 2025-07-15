// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/newProfile/reset_transaction_pin_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
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
      isLoading: false,
    );
  }

  Future<void> initiateTransactionPinReset() async {
    try {
      await RexApi.instance.initiateTransactionPinReset(
        authToken: ref.read(appAuthTokenProvider) ?? '',
        username: ref.watch(usernameProvider),
        entityCode: 'RMB',
      );
    } catch (error, _) {
      debugPrint(error.toString());
    }
  }

  Future<void> resetTransactionPin(BuildContext context, String pin) async {
    final username = ref.watch(usernameProvider);
    final request = ResetTransactionPinRequest(
      otp: state.otpController.text,
      mobileNumber: '',
      username: username,
      entityCode: 'RMB',
      transactionPin: pin,
    );
    state = state.copyWith(isLoading: true);
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.resetTransactionPin(
        authToken: ref.read(appAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(isLoading: false);
      context.showToast(message: "Transaction PIN set successfully.");
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.resetPassword3,
          isDismissible: false,
          onPressed: () {
            context.go(Routes.dashboardMore);
          },
        );
      }
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      context.showToast(message: error.toString());
    }
  }
}
