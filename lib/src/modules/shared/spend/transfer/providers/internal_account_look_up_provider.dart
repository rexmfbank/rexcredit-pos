import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

import '../../../../shared/providers/app_preference_provider.dart';

final internalAccountLookUpProvider =
    AsyncNotifierProvider<InternalAccountLookUpNotifier, AccountLookUpResponse>(
  () => InternalAccountLookUpNotifier(),
);

class InternalAccountLookUpNotifier
    extends AsyncNotifier<AccountLookUpResponse> {
  @override
  FutureOr<AccountLookUpResponse> build() {
    return AccountLookUpResponse.empty();
  }

  Future<void> doInternalAccountLookUp({
    required AccountLookUpRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .performInternalAccountLookUp(token: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
