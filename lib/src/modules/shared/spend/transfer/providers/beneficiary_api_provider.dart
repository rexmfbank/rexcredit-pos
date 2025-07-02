import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

import '../../../../shared/providers/app_preference_provider.dart';

final saveBeneficiaryApiProvider = AsyncNotifierProvider<
    SaveTransactionBeneficiaryNotifier, SaveBeneficiaryResponse>(
  () => SaveTransactionBeneficiaryNotifier(),
);

class SaveTransactionBeneficiaryNotifier
    extends AsyncNotifier<SaveBeneficiaryResponse> {
  @override
  FutureOr<SaveBeneficiaryResponse> build() {
    return SaveBeneficiaryResponse.empty();
  }

  Future<void> saveTransactionBeneficiary(
      {required SaveBeneficiaryRequest request,
      VoidCallback? onSuccess}) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .saveBeneficiary(authToken: authToken, request: request);
      state = AsyncValue.data(res);
      onSuccess?.call();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
