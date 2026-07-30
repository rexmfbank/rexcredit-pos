// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/model/trans_dispute_state.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/widgets/extension_on_snackbar.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final transDisputeProvider =
    NotifierProvider<TransDisputeNotifier, TransDisputeState>(
      TransDisputeNotifier.new,
    );

final disputeReasonsProvider =
    FutureProvider.autoDispose<List<DisputeReasonItem>>((ref) async {
      final config = AppKeysStorage.getConfig();
      return RexApi.instance.posDisputeReasons(
        header: HeaderWithAuthNoCrypt(
          appVersion: config.appVersionLocal,
          deviceID: config.serialNumber,
          authToken: config.authToken,
          geoLong: config.longitude,
          geoLat: config.latitude,
        ),
      );
    });

class TransDisputeNotifier extends Notifier<TransDisputeState> {
  @override
  TransDisputeState build() {
    return TransDisputeState(
      isLoading: false,
      reasonController: TextEditingController(),
      descriptionController: TextEditingController(),
    );
  }

  void selectDisputeReason(DisputeReasonItem reason) {
    state.reasonController.text = reason.label;
    state = state.copyWith(disputeReason: reason);
  }

  void validateInput(BuildContext context) {
    if (state.disputeReason == null) {
      context.showSnack(message: "Please select a dispute reason");
      return;
    }
    if (state.descriptionController.text.trim().isEmpty) {
      context.showSnack(message: "Please input a description");
      return;
    }
    if (state.descriptionController.text.trim().length < 10) {
      context.showSnack(message: "Description must be at least 10 characters");
      return;
    }
    reportTransaction(context);
  }

  Future<void> reportTransaction(BuildContext context) async {
    final detail = ref.watch(memoryPosTransProvider);
    final config = AppKeysStorage.getConfig();
    final request = CreateDisputeRequest(
      transUniqueRef: detail.tranRefNo ?? '',
      rrn: detail.rrn ?? '',
      amount: detail.amount ?? 0,
      disputeReason: state.disputeReason!.code,
      description: state.descriptionController.text.trim(),
    );
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      authToken: config.authToken,
      geoLong: config.longitude,
      geoLat: config.latitude,
    );

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
