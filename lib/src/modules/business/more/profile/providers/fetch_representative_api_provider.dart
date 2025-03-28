import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final fetchRepresentativeApiProvider =
    AsyncNotifierProvider<FetchRepresentativeNotifier, FetchRepresentativeData>(
  () => FetchRepresentativeNotifier(),
);

class FetchRepresentativeNotifier
    extends AsyncNotifier<FetchRepresentativeData> {
  @override
  FutureOr<FetchRepresentativeData> build() {
    return const FetchRepresentativeData.empty();
  }

  Future<void> getBusinessRepresentative() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final email = ref.watch(userEmailProvider);
    try {
      final res = await RexApi.instance
          .fetchBusinessRepresentative(token: authToken, email: email);
      state = AsyncValue.data(res.data!);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

final getBusinessRepFutureProvider =
    FutureProvider<FetchRepresentativeData>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
  final businessRepData = await RexApi.instance.fetchBusinessRepresentative(
    token: authToken,
    email: ref.watch(userEmailProvider),
  );
  return businessRepData.data ?? const FetchRepresentativeData.empty();
});
