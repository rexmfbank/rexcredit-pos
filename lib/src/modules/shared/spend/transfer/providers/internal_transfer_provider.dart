import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/app_config.dart';

import '../../../../shared/providers/app_preference_provider.dart';

final internalTransferProvider =
    AsyncNotifierProvider<InternalTransferProvider, InternalTransferResponse>(
  () => InternalTransferProvider(),
);

class InternalTransferProvider extends AsyncNotifier<InternalTransferResponse> {
  @override
  FutureOr<InternalTransferResponse> build() {
    return InternalTransferResponse.empty();
  }

  Future<void> makeInternalTransfer({
    required BuildContext context,
    required InternalTransferRequest request,
    required String transactionPin,
    Function(TransferData)? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';

    try {
      final res = await RexApi.instance.performInternalTransfer(
        token: authToken,
        appVersion: ref.read(appVersionProvider),
        request: request,
        transactionPin: transactionPin,
      );
      state = AsyncValue.data(res);
      onSuccess?.call(res.data ?? TransferData());
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
