// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/revamp/login/providers/session_timer.dart';
import 'package:rex_app/src/modules/revamp/spend/providers/user_state_notifier.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/login/model/login_screen_state.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';

// these two values are used in the LoginScreen to check
// for customer type and determine the dashboard to navigate to
const acctIndividual = 'individual';
const acctBusiness = 'business';

final loginProvider = NotifierProvider<LoginNotifier, LoginScreenState>(
  () => LoginNotifier(),
);

class LoginNotifier extends Notifier<LoginScreenState> {
  DeviceMetaData? meta;

  @override
  LoginScreenState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return LoginScreenState(
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      isLoading: false,
    );
  }

  Future<void> checkUserName() async {
    final username = await AppSecureStorage().getUserName();
    Timer(const Duration(milliseconds: 800), () {
      state = state.copyWith(
        usernameController: TextEditingController(text: username),
      );
    });
  }

  void validate(BuildContext context) async {
    if (state.usernameController.text.isNotBlank &&
        state.passwordController.text.isNotBlank) {
      login(context);
      return;
    }
    showModalActionError(
      context: context,
      title: Strings.validationError,
      errorText: Strings.pleaseFillAllFields,
    );
  }

  void clearFields() {
    state.usernameController.clear();
    state.passwordController.clear();
  }

  Future<void> login(
    BuildContext context, {
    String? username,
    String? pass,
  }) async {
    final request = LoginRequest(
      channelType: Strings.appChannelType,
      username: username ?? state.usernameController.text.trim(),
      password: pass ?? state.passwordController.text,
      refreshToken: '',
      language: Strings.appLanguage,
      deviceId: meta?.deviceNumber ?? '',
    );
    ref.read(usernameProvider.notifier).state = state.usernameController.text;
    ref.read(userPassProvider.notifier).state = state.passwordController.text;
    //
    state = state.copyWith(
      loginResponse: const AsyncValue.loading(),
      isLoading: true,
    );
    try {
      final apiResponse = await RexApi.instance.login(
        pushId: "",
        appVersion: ref.read(appVersionProvider),
        request: request,
        errorAction: () {},
      );
      state = state.copyWith(
        loginResponse: AsyncValue.data(apiResponse),
        isLoading: false,
      );
      ref.read(userPassProvider.notifier).state = 'N';
      _saveDetails(apiResponse.data, context);
    } catch (error, stackTrace) {
      state = state.copyWith(
        loginResponse: AsyncValue.error(error, stackTrace),
        isLoading: false,
      );
      if (error is CompleteVerifyOTPException) {
        ref.read(otpVerificationProvider.notifier).resendOtp(context: context);
        showModalActionSuccess(
          context: context,
          title: Strings.loginCompleteOTP2,
          subtitle: Strings.loginCompleteOTP,
          onPressed: () => context.go(Routes.otpVerify),
        );
      } else if (error is CompleteSecondOnboardException ||
          error is CompleteBusinessInfoException) {
        showModalActionSuccess(
          context: context,
          title: Strings.loginCompleteOnboard2,
          subtitle: Strings.loginCompleteOnboard,
          onPressed: () {
            context.go(Routes.accountType);
          },
        );
      } else if (error is CompleteBusinessDocsException) {
      } else if (error is CompleteBusinessDirectorsException) {
        showModalActionSuccess(
          context: context,
          title: Strings.loginCompleteOnboard2,
          subtitle: 'Plase continue to fill in business director details',
          onPressed: () {
            context.go(Routes.bizllcDirector);
          },
        );
      } else if (error is CompleteTransactionPINException) {
        showModalActionSuccess(
          context: context,
          title: Strings.loginCompletePIN2,
          subtitle: Strings.loginCompletePIN,
          onPressed: () {
            // ref
            //     .read(setTransactionPinProvider.notifier)
            //     .toggleFromSignUp(false);
            context.push(Routes.setTransactionPin);
          },
        );
      } else if (error is InvalidDeviceException) {
        ref
            .read(otpVerificationProvider.notifier)
            .resendOtp(context: context, actionCode: kChangeDevice);
        context.showToast(message: Strings.invalidDeviceTitle);
        context.go(Routes.verifyDevice);
      } else {
        context.showToast(message: error.toString());
      }
    }
  }

  void _saveDetails(LoginResponseData loginResponseData, BuildContext context) {
    ref
        .read(userStateNotifierProvider.notifier)
        .updateUser(user: loginResponseData);
    ref.read(appAuthTokenProvider.notifier).state =
        loginResponseData.ticketID ?? '';
    ref.read(userNubanProvider.notifier).state =
        loginResponseData.primaryAccountNo ?? '';
    ref.read(userFirstNameProvider.notifier).state =
        loginResponseData.firstname ?? '';
    ref.read(userFullNameProvider.notifier).state =
        loginResponseData.fullname ?? '';
    ref.read(usernameProvider.notifier).state =
        loginResponseData.username ?? '';
    loginResponseData.entityCode ?? '';
    ref.invalidate(userAcctBalanceProvider);
    ref.read(businessCodeProvider.notifier).state =
        loginResponseData.businessCode ?? '';
    AppSecureStorage().userNameVal = loginResponseData.username ?? '';
    AppSecureStorage().passwordVal = state.passwordController.text;
    clearFields();

    ref
        .read(sessionTimerProvider)
        .start(GoRouter.of(context), route: Routes.homeScreen);
    context.go(Routes.dashboardIndividual);
  }
}
