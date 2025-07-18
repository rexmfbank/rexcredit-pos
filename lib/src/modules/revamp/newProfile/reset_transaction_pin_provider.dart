// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/newProfile/reset_transaction_pin_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final resetTransactionPinProvider = AutoDisposeNotifierProvider<
  ResetTransactionPinNotifier,
  ResetTransactionPinOtpState
>(() => ResetTransactionPinNotifier());

class ResetTransactionPinNotifier
    extends AutoDisposeNotifier<ResetTransactionPinOtpState> {
  @override
  ResetTransactionPinOtpState build() {
    return ResetTransactionPinOtpState(
      pinController: TextEditingController(),
      otpController: TextEditingController(),
      newController: TextEditingController(),
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

  Future<void> resetTransactionPin(BuildContext context) async {
    if (state.newController.text.length > 4) {
      context.showToast(message: 'PIN must be 4 digits only');
      return;
    }
    final username = ref.watch(usernameProvider);
    final request = ResetTransactionPinRequest(
      otp: state.otpController.text,
      mobileNumber: '',
      username: username,
      entityCode: 'RMB',
      transactionPin: state.newController.text,
    );
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.resetTransactionPin(
        authToken: ref.read(appAuthTokenProvider) ?? '',
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(isLoading: false);
      context.showToast(message: "Transaction PIN set successfully.");
      context.go(Routes.dashboardMore);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      context.showToast(message: error.toString());
    }
  }
}
