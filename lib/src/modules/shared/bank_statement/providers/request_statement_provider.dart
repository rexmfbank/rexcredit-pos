// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/bank_statement/models/request_statement_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

final requestStatementProvider = AutoDisposeNotifierProvider<
    RequestStatementNotifier, RequestStatementState>(
  () => RequestStatementNotifier(),
);

class RequestStatementNotifier
    extends AutoDisposeNotifier<RequestStatementState> {
  @override
  RequestStatementState build() {
    return RequestStatementState(
      startDateController: TextEditingController(),
      endDateController: TextEditingController(),
      startDate: null,
      endDate: null,
      format: '',
    );
  }

  void onStartDateChange(DateTime? value) {
    state = state.copyWith(startDate: value!);
  }

  void onEndDateChange(DateTime? value) {
    state = state.copyWith(endDate: value!);
  }

  void validateAndSubmit(BuildContext context) {
    if (state.startDate == null || state.endDate == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.reqStatement4,
      );
    } else {
      _requestBankStatement(context);
    }
  }

  void onFormatDropdownChange(String? value) {
    state = state.copyWith(format: value!);
  }

  void _requestBankStatement(BuildContext context) async {
    final acctNo = ref.watch(userNubanProvider);
    final authToken = ref.watch(appAuthTokenProvider);
    final username = ref.watch(usernameProvider);
    //
    final request = BankStatementRequest(
      startDate: state.startDate!.dateYYYYMMDD(),
      endDate: state.endDate!.dateYYYYMMDD(),
      accountNumber: acctNo,
      username: username,
      format: state.format,
    );
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.requestBankStatement(
        authToken: authToken ?? '',
        request: request,
      );
      LoadingScreen.instance().hide();
      showModalActionSuccess(
        context: context,
        subtitle: StringAssets.reqStatement5,
        onPressed: () {
          context.go(Routes.dashboardIndividual);
        },
      );
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }
}
