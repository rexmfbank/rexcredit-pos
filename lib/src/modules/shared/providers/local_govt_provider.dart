import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final lgaListProvider =
    AsyncNotifierProvider<LgaListNotifier, List<LocalGovtData>>(
  () => LgaListNotifier(),
);

class LgaListNotifier extends AsyncNotifier<List<LocalGovtData>> {
  @override
  FutureOr<List<LocalGovtData>> build() {
    return _getInitialList();
  }

  Future<List<LocalGovtData>> _getInitialList() async {
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    final res = await RexApi.instance.getLocalGovt(
      stateId: 10,
      authToken: authToken,
    );
    return res;
  }

  void getLgaList({
    required int stateId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
      final res = await RexApi.instance.getLocalGovt(
        stateId: stateId,
        authToken: authToken,
      );
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
