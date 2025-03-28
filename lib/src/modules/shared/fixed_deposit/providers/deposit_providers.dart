import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';

///
/// FIXED DEPOSITS
///

final fetchFixedDepositInterestType =
    FutureProvider.autoDispose<List<DepositInterestTypeData>?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.depositInterestType(
    authToken: authToken ?? '',
    appVersion: ref.read(appVersionProvider),
    deviceId: deviceMeta?.deviceNumber ?? '',
    countryCode: 'NG',
  );
  return res.data;
});

final fetchFixedDepositDurations =
    FutureProvider.autoDispose<List<String>?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.depositDuration(
    authToken: authToken ?? '',
    appVersion: ref.read(appVersionProvider),
    deviceId: deviceMeta?.deviceNumber ?? '',
  );
  return res.data;
});

final fetchFixedDepositWalletBalance =
    FutureProvider.autoDispose<FixedDepositWalletBalance?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.depositWallet(
    authToken: authToken ?? '',
    appVersion: ref.read(appVersionProvider),
    deviceId: deviceMeta?.deviceNumber ?? '',
  );
  return res;
});

final fetchFixedDepositList =
    FutureProvider.autoDispose<List<DepositData>?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.depositList(
    authToken: authToken ?? '',
    appVersion: ref.read(appVersionProvider),
    deviceId: deviceMeta?.deviceNumber ?? '',
  );
  return res.data;
});

final inMemoryFixedDepositData = StateProvider<DepositData>((ref) {
  return const DepositData.empty();
});
