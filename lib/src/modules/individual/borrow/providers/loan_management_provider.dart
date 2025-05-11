// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/borrow/states/individual_loan_management_screen_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final loanManagementProvider = StateNotifierProvider<LoanManagementNotifier,
    IndividualLoanManagementScreenState>((ref) {
  var authToken = ref.watch(userAuthTokenProvider) ?? '';
  return LoanManagementNotifier(authToken, ref);
});

class LoanManagementNotifier
    extends StateNotifier<IndividualLoanManagementScreenState> with LocatorMix {
  LoanManagementNotifier(this.authToken, this.ref)
      : super(IndividualLoanManagementScreenState.initial());

  final String authToken;
  final StateNotifierProviderRef ref;

  Future<void> fetchLoanDetail(
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      var apiResponse = await RexApi.instance.getLoanDetail(token: authToken);
      state = state.copyWith(isLoading: false, loanDetail: apiResponse.data);
      debugPrint("API RESPONSE LOAN DETAIL: ${apiResponse.data}");
    } catch (error, _) {
      state = state.copyWith(isLoading: false, error: error.toString());
      debugPrint("API RESPONSE LOAN DETAIL ERROR: $error");
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  ///This function allows me to reset the error field after it has been shown to
  ///the User so it does not pop up automatically when user retries
  void updateApiError() {
    state = state.copyWith(error: '');
  }
}
