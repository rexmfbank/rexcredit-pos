import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

final fetchDisputesProvider =
    FutureProvider.autoDispose<List<FetchDisputeData>?>((ref) async {
      final config = AppKeysStorage.getConfig();
      final res = await RexApi.instance.fetchDisputes(
        header: HeaderWithAuthNoCrypt(
          appVersion: config.appVersionLocal,
          deviceID: config.serialNumber,
          authToken: config.authToken,
          geoLong: config.longitude,
          geoLat: config.latitude,
        ),
      );
      return res.data;
    });
