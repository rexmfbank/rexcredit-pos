import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final securityQuestionListProvider = AsyncNotifierProvider<
    SecurityQuestionListNotifier, List<FetchLookupDataByCodeResponseData>>(
  () => SecurityQuestionListNotifier(),
);

class SecurityQuestionListNotifier
    extends AsyncNotifier<List<FetchLookupDataByCodeResponseData>> {
  @override
  FutureOr<List<FetchLookupDataByCodeResponseData>> build() {
    return _getInitialList();
  }

  Future<List<FetchLookupDataByCodeResponseData>> _getInitialList() async {
    return [];
  }

  void getSecurityQuestionList() async {
    state = const AsyncValue.loading();
    try {
      final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
      final res = await RexApi.instance.fetchlookupDataByCode(
          authToken: authToken, lookupCode: 'SECURITY_QUESTION');
      state = AsyncValue.data(res.list);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

final nextOfKinRelationshipListProvider = AsyncNotifierProvider<
    NextOfKinRelationshipListNotifier, List<FetchLookupDataByCodeResponseData>>(
  () => NextOfKinRelationshipListNotifier(),
);

class NextOfKinRelationshipListNotifier
    extends AsyncNotifier<List<FetchLookupDataByCodeResponseData>> {
  @override
  FutureOr<List<FetchLookupDataByCodeResponseData>> build() {
    return _getInitialList();
  }

  Future<List<FetchLookupDataByCodeResponseData>> _getInitialList() async {
    return [];
  }

  void getNextOfKinRelationshipList() async {
    state = const AsyncValue.loading();
    try {
      final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
      final res = await RexApi.instance.fetchlookupDataByCode(
          authToken: authToken, lookupCode: 'RELATIONSHIP');
      state = AsyncValue.data(res.list);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
