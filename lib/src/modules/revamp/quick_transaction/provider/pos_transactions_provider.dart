import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final posTransactionsProvider =
    FutureProvider.autoDispose<List<PosTransactionsResponseData>>((ref) async {
      final dd = ref.watch(posAuthTokenProvider);
      final ee = ref.watch(appVersionProvider);
      final ss = await RexApi.instance.posTransactions(
        authToken: dd ?? '',
        appVersion: ee,
        request: PosTransactionsRequest(
          orderType: "descending",
          pageSize: 20,
          pageIndex: 0,
        ),
      );
      return ss.data;
    });

final inMemoryTransactionProvider = StateProvider<PosTransactionsResponseData>((
  ref,
) {
  return PosTransactionsResponseData.empty();
});

final fetchDisputesProvider =
    FutureProvider.autoDispose<List<FetchDisputeData>?>((ref) async {
      final authToken = ref.watch(appAuthTokenProvider);
      final res = await RexApi.instance.fetchDisputes(
        authToken: authToken ?? '',
      );
      return res.data;
    });
