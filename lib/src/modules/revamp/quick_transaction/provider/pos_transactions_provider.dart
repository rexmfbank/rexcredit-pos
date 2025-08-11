import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/secure_storage.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final posTransactionsProvider =
    FutureProvider.autoDispose<List<PosTransactionsResponseData>>((ref) async {
      final authToken = ref.watch(posAuthTokenProvider);
      final appVersion = ref.watch(appVersionProvider);
      final acctNo = await SecureStorage().getPosNuban();
      //
      final apiResponse = await RexApi.instance.posTransactions(
        authToken: authToken ?? '',
        appVersion: appVersion,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageSize: 20,
          pageIndex: 0,
          accountNo: acctNo,
        ),
      );
      return apiResponse.data;
    });

final inMemoryTransactionProvider = StateProvider<PosTransactionsResponseData>((
  ref,
) {
  return PosTransactionsResponseData.empty();
});

final posFetchDisputeProvider =
    FutureProvider.autoDispose<List<FetchDisputeData>?>((ref) async {
      final authToken = ref.watch(posAuthTokenProvider);
      final appVersion = ref.watch(appVersionProvider);
      final res = await RexApi.instance.posFetchDispute(
        authToken: authToken ?? '',
        appVersion: appVersion,
      );
      return res.data;
    });
