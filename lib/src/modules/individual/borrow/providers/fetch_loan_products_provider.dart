import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final getLoanProductsProvider =
    AsyncNotifierProvider<GetLoanProductsNotifier, List<LoanProductModel>>(
  () => GetLoanProductsNotifier(),
);

class GetLoanProductsNotifier extends AsyncNotifier<List<LoanProductModel>> {
  @override
  FutureOr<List<LoanProductModel>> build() {
    return [];
  }

  Future<void> getLoanProducts() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    try {
      final res = await RexApi.instance.getLoanProducts(authToken: authToken);
      state = AsyncValue.data(res.data!);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
