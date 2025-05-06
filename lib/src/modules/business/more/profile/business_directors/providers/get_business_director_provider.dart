import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final getBusinessDirectorsProvider = AsyncNotifierProvider<
    GetBusinessDirectorsNotifier, List<GetDirectorsResponseData>>(
  () => GetBusinessDirectorsNotifier(),
);

class GetBusinessDirectorsNotifier
    extends AsyncNotifier<List<GetDirectorsResponseData>> {
  @override
  FutureOr<List<GetDirectorsResponseData>> build() {
    return [];
  }

  Future<void> getBusinessDirectors() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final businessCode = ref.watch(businessCodeProvider);

    try {
      final res = await RexApi.instance
          .getDirectors(token: authToken, businessCode: businessCode);
      state = AsyncValue.data(res.data);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
