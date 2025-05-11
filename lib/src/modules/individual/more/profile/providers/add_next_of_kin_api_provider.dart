import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final addNextOfKinApiProvider =
    AsyncNotifierProvider<AddNextOfKinApiNotifier, AddNextOfKinResponse>(
  () => AddNextOfKinApiNotifier(),
);

class AddNextOfKinApiNotifier extends AsyncNotifier<AddNextOfKinResponse> {
  @override
  FutureOr<AddNextOfKinResponse> build() {
    return AddNextOfKinResponse.empty();
  }

  Future<void> addNextOfKin({
    required AddNextOfKinRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .addNextOfKin(authToken: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
