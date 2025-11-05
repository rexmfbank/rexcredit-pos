// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/model/change_password_state.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final changePasswordApiProvider =
    NotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
      () => ChangePasswordNotifier(),
    );

class ChangePasswordNotifier extends Notifier<ChangePasswordState> {
  @override
  ChangePasswordState build() {
    return ChangePasswordState(
      currentPassController: TextEditingController(),
      newPassController: TextEditingController(),
      confirmPassController: TextEditingController(),
      isLoading: false,
      newPassField: "",
    );
  }

  void onChangeNewPasswordField(String value) {
    state = state.copyWith(newPassField: value);
  }

  Future<void> changePassword(BuildContext context) async {
    if (!state.newPassController.text.passwordCheck()) {
      context.showToast(message: "Password does not meet requirements");
      return;
    } else if (!(state.newPassController.text ==
        state.confirmPassController.text)) {
      context.showToast(message: "Password does not meet requirements");
      return;
    }
    //
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    state = state.copyWith(isLoading: true);
    try {
      final request = ChangePinRequest(
        oldPin: state.currentPassController.text,
        newPin: state.newPassController.text,
        entityCode: 'RMB',
        deviceId:
            ref.watch(deviceMetaProvider).asData?.value.deviceNumber ?? '',
      );
      await RexApi.instance.changePassword(
        token: authToken,
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(isLoading: false);
      context.showToast(message: Strings.passwordChangedSuccessfully);
      context.go(Routes.homeScreen);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
