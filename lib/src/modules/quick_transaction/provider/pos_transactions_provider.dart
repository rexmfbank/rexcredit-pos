import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final inMemoryTransactionProvider = StateProvider<PosTransactionsResponseData>((
  ref,
) {
  return PosTransactionsResponseData.empty();
});

final posFetchDisputeProvider =
    FutureProvider.autoDispose<List<FetchDisputeData>?>((ref) async {
      final config = AppKeysStorage.getConfig();
      final header = HeaderWithAuthNoCrypt(
        appVersion: config.appVersionLocal,
        deviceID: config.serialNumber,
        geoLong: config.longitude,
        geoLat: config.latitude,
        authToken: config.authToken,
      );
      final res = await RexApi.instance.posFetchDispute(header: header);
      return res.data;
    });
