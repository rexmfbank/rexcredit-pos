import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final faqProvider =
    AsyncNotifierProvider<FaqNotifier, List<FetchLookupDataByCodeResponseData>>(
  () => FaqNotifier(),
);

class FaqNotifier
    extends AsyncNotifier<List<FetchLookupDataByCodeResponseData>> {
  @override
  FutureOr<List<FetchLookupDataByCodeResponseData>> build() {
    return [];
  }

  Future<void> getFrequentlyAskedQuestions() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .fetchlookupDataByCode(authToken: authToken, lookupCode: 'FAQ');
      state = AsyncValue.data(res.list);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
