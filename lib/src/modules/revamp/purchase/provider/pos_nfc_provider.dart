// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/pos_nfc_state.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';

final posNfcProvider = NotifierProvider<PosNfcNotifier, PosNfcState>(
  PosNfcNotifier.new,
);

class PosNfcNotifier extends Notifier<PosNfcState> {
  @override
  PosNfcState build() {
    return PosNfcState(isLoading: false);
  }

  Future<void> submitNfcPurchase({
    required BuildContext context,
    required String payLoad,
  }) async {
    state = state.copyWith(isLoading: true);
    final nfcRequest = PosNfcRequest(
      amount: 4000,
      terminalId: "P332600087595",
      rrn: '123456654321',
      stan: '123456',
      datetime: formatDateTimeSimple(DateTime.now()),
      cardPayload: payLoad,
      pin: '1234',
    );
    debugPrintDev('submitNfcPurchase request: ${nfcRequest.toJson()}');
    //
    bool success = false;
    int retryCount = 0;
    const maxRetries = 3;
    //
    while (!success && retryCount < maxRetries) {
      try {
        await RexApi.instance.posNfcPurchase(
          request: nfcRequest,
          appVersion: ref.read(appVersionProvider),
          authToken: ref.read(posAuthTokenProvider) ?? '',
        );
        success = true;
        context.showToast(message: "Transaction successful");
        debugPrintDev('submitNfcPurchase success');
      } catch (e) {
        retryCount++;
        debugPrintDev('submitNfcPurchase failed, attempt $retryCount...');
        if (retryCount >= maxRetries) {
          state = state.copyWith(isLoading: false);
          context.showToast(
            message: "Transaction submission failed. Please try again.",
          );
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    //
    state = state.copyWith(isLoading: false);
  }
}

String formatDateTimeSimple(DateTime dt) {
  // ISO string looks like: "2025-01-01T10:00:00.000Z"
  String iso = dt.toIso8601String();

  // Replace the 'T' with a space and take the first 16 characters
  return iso.replaceFirst('T', ' ').substring(0, 16);
}
