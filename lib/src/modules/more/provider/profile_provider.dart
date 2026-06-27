import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/utils/app_keys.dart';

final profileProvider = FutureProvider.autoDispose<ProfileResData>((ref) async {
  final config = AppKeysStorage.getConfig();
  final header = HeaderWithAuthNoCrypt(
    appVersion: config.appVersionLocal,
    deviceID: config.serialNumber,
    authToken: config.loginAuthToken,
    geoLong: config.longitude,
    geoLat: config.latitude,
  );
  final res = await RexApi.instance.profile(header: header);
  return res;
});
