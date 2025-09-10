import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final termsAndPrivacyPolicyProvider = AsyncNotifierProvider<
    TermsConditionsAndPolicyNotifier, TermsConditionsAndPolicyResponse>(
  () => TermsConditionsAndPolicyNotifier(),
);

class TermsConditionsAndPolicyNotifier
    extends AsyncNotifier<TermsConditionsAndPolicyResponse> {
  @override
  FutureOr<TermsConditionsAndPolicyResponse> build() {
    return TermsConditionsAndPolicyResponse.empty();
  }

  Future<void> getTermsConditionsAndPolicy() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
    try {
      final res =
          await RexApi.instance.getTermsConditionsAndPolicy(token: authToken);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
