import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final storeSecurityQuestionApiProvider = AsyncNotifierProvider<
    StoreSecurityQuestionApiNotifier, StoreSecurityQuestionResponse>(
  () => StoreSecurityQuestionApiNotifier(),
);

class StoreSecurityQuestionApiNotifier
    extends AsyncNotifier<StoreSecurityQuestionResponse> {
  @override
  FutureOr<StoreSecurityQuestionResponse> build() {
    return StoreSecurityQuestionResponse.empty();
  }

  Future<void> setupSecurityQuestion({
    required StoreSecurityQuestionRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .storeSecurityQuestion(token: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
