import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final dashboardHomePageViewIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final userAcctBalanceProvider =
    FutureProvider.autoDispose<InternalBalanceEnquiryResponse>((ref) async {
      final authToken = ref.watch(appAuthTokenProvider);
      final userAcctNumber = ref.watch(userNubanProvider);
      //
      final res = await RexApi.instance.makeInternalBalanceEnquiry(
        token: authToken ?? '',
        request: InternalBalanceEnquiryRequest(
          bankCode: 'RMB',
          accountNumber: userAcctNumber,
        ),
      );
      return res;
    });
