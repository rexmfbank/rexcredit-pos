// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/model/set_transaction_pin_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final setTransactionPinProvider =
    NotifierProvider<SetTransactionPinNotifier, SetTransactionPinState>(
  () => SetTransactionPinNotifier(),
);

class SetTransactionPinNotifier extends Notifier<SetTransactionPinState> {
  DeviceMetaData? meta;

  @override
  SetTransactionPinState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return const SetTransactionPinState(
      pin: '',
      confirmPin: '',
    );
  }

  void setPin(String value) {
    state = state.copyWith(pin: value);
  }

  void setConfirmPin(String value) {
    state = state.copyWith(confirmPin: value);
  }

  void toggleFromSignUp(bool value) =>
      state = state.copyWith(fromSignUp: value);

  void validatePIN(BuildContext context) {
    final isValidPIN = TextfieldValidator.validatePIN(state.pin);
    if (isValidPIN) {
      context.go(RouteName.confirmTransactionPin);
    } else {
      showModalActionError(
        context: context,
        title: StringAssets.weakPINtext,
        errorText: StringAssets.weakPINtext2,
      );
    }
  }

  Future<void> setTransactionPin(BuildContext context) async {
    final entityCode = ref.watch(userEntityCodeProvider);
    if (state.pin != state.confirmPin) {
      showModalActionError(
        context: context,
        title: StringAssets.incorrectPINtext,
        errorText: StringAssets.incorrectPINtext2,
      );
      return;
    }
    //
    final username = ref.watch(usernameProvider);
    final request = SetTransactionPinRequest(
      pin: state.pin,
      username: username,
      entityCode: entityCode.isEmpty ? 'RMB' : entityCode,
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.setTransactionPin(
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      LoadingScreen.instance().hide();
      _checkForOnboardingCompletion(context);
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  Future<void> _checkForOnboardingCompletion(BuildContext context) async {
    final name = ref.watch(usernameProvider);
    final pass = ref.watch(userPassProvider);
    ref.read(loginProvider.notifier).login(context, username: name, pass: pass);
  }
}
