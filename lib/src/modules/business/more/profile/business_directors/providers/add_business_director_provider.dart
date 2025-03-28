import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final addBusinessDirectorsProvider =
    AsyncNotifierProvider<AddBusinessDirectorsNotifier, AddDirectorsResponse>(
  () => AddBusinessDirectorsNotifier(),
);

class AddBusinessDirectorsNotifier
    extends AsyncNotifier<AddDirectorsResponse> {
  
  @override
  FutureOr<AddDirectorsResponse> build() {
    return AddDirectorsResponse.empty();
  }

  Future<void> addBusinessDirectors({required AddDirectorsRequest request}) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .addDirectors(authToken: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}