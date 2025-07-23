import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/dashboard/models/transaction_dispute_state.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/user_recent_transaction_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';

final transactionDisputeProvider =
    NotifierProvider<TransactionDisputeNotifier, TransactionDisputeState>(
  () => TransactionDisputeNotifier(),
);

class TransactionDisputeNotifier extends Notifier<TransactionDisputeState> {
  @override
  TransactionDisputeState build() {
    return TransactionDisputeState(
      textController: TextEditingController(),
    );
  }

  void validateInput(BuildContext context) {
    if (state.textController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: 'Please input a message',
      );
    } else {
      reportTransaction(context);
    }
  }

  Future<void> reportTransaction(BuildContext context) async {
    final authToken = ref.watch(appAuthTokenProvider);
    final tId = ref.watch(inMemoryRecentTransaction);
    final username = ref.watch(usernameProvider);
    //
    final request = CreateDisputeRequest(
      transactionId: tId.tranUniqueRefNo ?? '',
      username: username,
      disputeMessage: state.textController.text,
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      await RexApi.instance.createDispute(
        authToken: authToken ?? '',
        request: request,
      );
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionSuccess(
          context: context,
          subtitle: 'Report submitted ',
          onPressed: () {
            context.go(Routes.dashboardIndividual);
          },
        );
      }
    } catch (error) {
      LoadingScreen.instance().hide();
      if (context.mounted) {
        showModalActionError(context: context, errorText: error.toString());
      }
    }
  }
}
