import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final createRepresentativeApiProvider =
    AsyncNotifierProvider<CreateRepresentativeApiNotifier, CreateRepresentativeResponse>(
  () => CreateRepresentativeApiNotifier(),
);

class CreateRepresentativeApiNotifier extends AsyncNotifier<CreateRepresentativeResponse> {
  @override
  FutureOr<CreateRepresentativeResponse> build() {
    return CreateRepresentativeResponse.empty();
  }

  Future<void> createBusinessRepresentative({
    required CreateRepresentativeRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .createBusinessRepresentative(token: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
