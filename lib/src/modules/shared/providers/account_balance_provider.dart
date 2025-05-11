import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final accountBalanceEnquiryProvider = AsyncNotifierProvider<
    AccountBalanceEnquiryNotifier, InternalBalanceEnquiryResponse>(
  () => AccountBalanceEnquiryNotifier(),
);

class AccountBalanceEnquiryNotifier
    extends AsyncNotifier<InternalBalanceEnquiryResponse> {
  @override
  FutureOr<InternalBalanceEnquiryResponse> build() {
    return InternalBalanceEnquiryResponse.empty();
  }

  Future<void> checkAccountBalance({
    required InternalBalanceEnquiryRequest request,
  }) async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance
          .makeInternalBalanceEnquiry(token: authToken, request: request);
      state = AsyncValue.data(res);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
