// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/model/security_question_state.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
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
  @override
  SecurityQuestionState build() {
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
