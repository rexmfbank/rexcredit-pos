// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/model/trans_dispute_state.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

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
    final detail = ref.watch(inMemoryTransactionProvider);
    final config = AppKeysStorage.getConfig();
    //
    final request = CreateDisputeRequest(
      transactionId: detail.tranRefNo ?? '',
      username: config.baasNuban,
      disputeMessage: state.textController.text,
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );
    //
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.posCreateDispute(header: header, request: request);
      state = state.copyWith(isLoading: false);
      context.showSnack(message: "Dispute submitted");
      context.go(Routes.homeScreen);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      context.showSnack(message: error.toString());
    }
  }
}
