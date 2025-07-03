import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final posTransactionsProvider =
    FutureProvider<List<PosTransactionsResponseData>>((ref) async {
  final dd = ref.watch(posAuthTokenProvider);
  final ee = ref.watch(appVersionProvider);
  final ss = await RexApi.instance.posTransactions(
    authToken: dd ?? '',
    appVersion: ee,
    request: PosTransactionsRequest(orderType: "descending"),
  );
  return ss.data;
});
