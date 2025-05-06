import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final getSingleLoanProductProvider =
    AsyncNotifierProvider<GetSingleLoanProductNotifier, LoanProductModel>(
  () => GetSingleLoanProductNotifier(),
);

class GetSingleLoanProductNotifier extends AsyncNotifier<LoanProductModel> {
  @override
  FutureOr<LoanProductModel> build() {
    return const LoanProductModel.empty();
  }

  Future<void> getSingleLoanProduct() async {
    state = const AsyncValue.loading();
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';
    final loanProductCode = ref.watch(loanProductCodeProvider);
    try {
      final res = await RexApi.instance.getSingleLoanProduct(
          authToken: authToken, productCode: loanProductCode);
      state = AsyncValue.data(res.data!);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}
