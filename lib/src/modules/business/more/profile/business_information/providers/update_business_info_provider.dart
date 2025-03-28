import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final updateBusinessInfoProvider =
    AsyncNotifierProvider<UpdateBusinessInfoNotifier, UpdateBusinessResponse>(
  () => UpdateBusinessInfoNotifier(),
);

class UpdateBusinessInfoNotifier extends AsyncNotifier<UpdateBusinessResponse> {
  @override
  FutureOr<UpdateBusinessResponse> build() {
    return UpdateBusinessResponse.empty();
  }

  Future<void> updateBusinessInfo({
    required UpdateBusinessRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .updateBusiness(authToken: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
