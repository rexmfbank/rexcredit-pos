import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/forgot_password/model/reset_password_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final resetPasswordProvider =
    AutoDisposeNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  () => ResetPasswordNotifier(),
);

class ResetPasswordNotifier extends AutoDisposeNotifier<ResetPasswordState> {
  @override
  ResetPasswordState build() {
    return ResetPasswordState(
      passwordController: TextEditingController(),
      otpController: TextEditingController(),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    if (state.passwordController.text.isBlank ||
        state.otpController.text.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyResetPassField,
        title: StringAssets.emptyValueText,
      );
      return;
    }
    final username = ref.watch(usernameProvider);
    final entityCode = ref.watch(userEntityCodeProvider);

    //
    final request = SelfPasswordResetRequest(
      otp: state.otpController.text,
      mobileNumber: '',
      username: username,
      entityCode: entityCode,
      newPassword: state.passwordController.text,
    );
    state = state.copyWith(apiResponse: const AsyncValue.loading());
    LoadingScreen.instance().show(context: context);
    try {
      final apiResponse = await RexApi.instance.selfPasswordReset(
        appVersion: ref.read(appVersionProvider),
        request: request,
      );
      state = state.copyWith(apiResponse: AsyncValue.data(apiResponse));
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: StringAssets.resetPassword3,
          isDismissible: false,
          onPressed: () {
            context.go(RouteName.login);
          },
        );
      }
    } catch (error, stackTrace) {
      LoadingScreen.instance().hide();
      state = state.copyWith(apiResponse: AsyncValue.error(error, stackTrace));
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }
}
