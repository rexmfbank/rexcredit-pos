import 'package:rex_api/rex_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';

///
/// TARGET SAVINGS
///

final fetchSavingsListProvider =
    FutureProvider.autoDispose<List<FetchTargetSavingsData>?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.fetchTargetSavings(
    authToken: authToken ?? '',
    deviceId: deviceMeta?.deviceNumber ?? '',
  );
  return res.data;
});

final fetchSavingsWalletBalance =
    FutureProvider.autoDispose<SavingsBalance?>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.getSavingsWallet(
    authToken: authToken ?? '',
    deviceId: deviceMeta?.deviceNumber ?? '',
  );
  return res.data;
});

final fetchSavingsTransaction = FutureProvider.autoDispose
    .family<List<SavingsTransactionData>?, SavingsTranParam>(
        (ref, param) async {
  final authToken = ref.watch(userAuthTokenProvider);
  final deviceMeta = ref.watch(deviceMetaProvider).asData?.value;
  //
  final res = await RexApi.instance.getSavingsTransaction(
    authToken: authToken ?? '',
    deviceId: deviceMeta?.deviceNumber ?? '',
    pageNumber: param.pageNumber,
    pageSize: param.pageSize,
  );
  return res.data;
});

final inMemoryTargetSavingData = StateProvider<FetchTargetSavingsData>((ref) {
  return const FetchTargetSavingsData.empty();
});

class SavingsTranParam {
  final int pageNumber;
  final int pageSize;

  const SavingsTranParam({
    required this.pageNumber,
    required this.pageSize,
  });
}
