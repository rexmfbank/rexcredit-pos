// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/model/trans_dispute_state.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final transDisputeProvider =
    NotifierProvider<TransDisputeNotifier, TransDisputeState>(
      TransDisputeNotifier.new,
    );

class TransDisputeNotifier extends Notifier<TransDisputeState> {
  @override
  TransDisputeState build() {
    return TransDisputeState(
      isLoading: false,
      textController: TextEditingController(),
    );
  }

  void validateInput(BuildContext context) {
    if (state.textController.text.isEmpty) {
      context.showToast(message: "Please input a message");
    } else {
      reportTransaction(context);
    }
  }

  Future<void> reportTransaction(BuildContext context) async {
    final authToken = ref.watch(posAuthTokenProvider);
    final detail = ref.watch(inMemoryTransactionProvider);
    final username = ref.watch(usernameProvider);
    final appVersion = ref.watch(appVersionProvider);
    //
    final request = CreateDisputeRequest(
      transactionId: detail.tranUniqRefNo ?? '',
      username: username,
      disputeMessage: state.textController.text,
    );
    //
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.posCreateDispute(
        authToken: authToken ?? '',
        request: request,
        appVersion: appVersion,
      );
      state = state.copyWith(isLoading: false);
      context.showToast(message: "Dispute submitted");
      context.go(Routes.homeScreen);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      context.showToast(message: error.toString());
    }
  }
}
