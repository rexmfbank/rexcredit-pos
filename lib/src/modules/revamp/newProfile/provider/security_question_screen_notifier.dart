// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/model/security_question_state.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final securityQuestionFuture =
    FutureProvider.autoDispose<List<FetchLookupDataByCodeResponseData>>((
      ref,
    ) async {
      final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
      final res = await RexApi.instance.fetchlookupDataByCode(
        authToken: authToken,
        lookupCode: 'SECURITY_QUESTION',
      );
      return res.list;
    });

final securityQuestionScreenProvider = AutoDisposeNotifierProvider<
  SecurityQuestionScreenNotifier,
  SecurityQuestionState
>(SecurityQuestionScreenNotifier.new);

class SecurityQuestionScreenNotifier
    extends AutoDisposeNotifier<SecurityQuestionState> {
  //
  DeviceMetaData? meta;

  @override
  SecurityQuestionState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return SecurityQuestionState(
      pinController: TextEditingController(),
      fetchValue: null,
      answerController: TextEditingController(),
      isLoading: false,
    );
  }

  void onDropdownChange(FetchLookupDataByCodeResponseData? value) {
    state = state.copyWith(fetchValue: value);
  }

  Future<void> validateTransactionPin({required BuildContext context}) async {
    if (state.pinController.text.length < 4) {
      context.showToast(message: 'PIN must be 4 digits only.');
      return;
    }
    state = state.copyWith(isLoading: true);
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      await RexApi.instance.validateTransactionPIN(
        authToken: authToken,
        transactionPin: state.pinController.text,
        userName: ref.watch(usernameProvider),
        deviceId: meta?.deviceNumber ?? '',
      );
      state = state.copyWith(isLoading: false);
      context.push("${Routes.dashboardMore}/${Routes.securityQuestionChange}");
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      if (error is AccountLockException) {
        context.showToast(
          message: "Account locked after multiple failed attempts",
        );
        context.go(Routes.login);
      } else {
        context.showToast(message: error.toString());
      }
    }
  }

  Future<void> submitQuestion({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      final appAuthToken = ref.watch(appAuthTokenProvider) ?? '';
      final request = StoreSecurityQuestionRequest(
        question: state.fetchValue?.name ?? '',
        answer: state.answerController.text,
      );
      await RexApi.instance.storeSecurityQuestion(
        token: appAuthToken,
        request: request,
      );
      state = state.copyWith(isLoading: false);
      context.showToast(message: 'Question submitted succesfully');
      context.go(Routes.dashboardMore);
    } catch (error, _) {
      state = state.copyWith(isLoading: false);
      context.showToast(message: error.toString());
    }
  }
}
