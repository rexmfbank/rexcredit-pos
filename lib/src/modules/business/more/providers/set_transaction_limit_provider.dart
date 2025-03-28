import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final setWithdrawalLimitProvider =
    AsyncNotifierProvider<SetWithdrawalLimitNotifier, SetWithdrawalLimitResponse>(
  () => SetWithdrawalLimitNotifier(),
);

class SetWithdrawalLimitNotifier
    extends AsyncNotifier<SetWithdrawalLimitResponse> {
  
  @override
  FutureOr<SetWithdrawalLimitResponse> build() {
    return SetWithdrawalLimitResponse.empty();
  }

  Future<void> setWithdrawalLimit({required SetWithdrawalLimitRequest request}) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .setWithdrawalLimit(authToken: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}