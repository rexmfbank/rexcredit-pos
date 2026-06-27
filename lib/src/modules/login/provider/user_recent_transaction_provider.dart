import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/utils/app_keys.dart';

final userRecentTransactionProvider = FutureProvider.autoDispose<TData>((
  ref,
) async {
  final config = AppKeysStorage.getConfig();
  final header = HeaderWithAuthNoCrypt(
    appVersion: config.appVersionLocal,
    deviceID: config.serialNumber,
    authToken: config.loginAuthToken,
    geoLong: config.longitude,
    geoLat: config.latitude,
  );
  final request = TransHistoryRequest(accountNumber: config.loginNuban);
  final res = await RexApi.instance.transactionHistory(
    header: header,
    request: request,
  );
  return res;
});

final inMemoryRecentTransaction = StateProvider<Transaction>((ref) {
  return Transaction.empty();
});
