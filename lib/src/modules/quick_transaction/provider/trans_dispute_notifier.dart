// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/model/trans_dispute_state.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/app_preference_provider.dart';
import 'package:rex_app/src/modules/utils/snack_bar_ext.dart';

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
      context.showSnack(message: "Please input a message");
      return;
    } else if (state.textController.text.length < 10) {
      context.showSnack(message: "Message must be at least 10 characters");
      return;
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
      transactionId: detail.tranRefNo ?? '',
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
      context.showSnack(message: "Dispute submitted");
      context.go(Routes.homeScreen);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: error.toString());
    }
  }
}
