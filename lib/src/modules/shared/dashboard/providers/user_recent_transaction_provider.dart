import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final userRecentTransactionProvider = FutureProvider.autoDispose
    .family<List<TransferData>?, RecentTransactionParam>((ref, param) async {
  //
  final authToken = ref.watch(appAuthTokenProvider);
  final nuban = ref.watch(userNubanProvider);
  //
  final request = MiniStatementRequest(
    accountNo: nuban,
    entityCode: 'RMB',
    pageIndex: param.pageIndex ?? 1,
    pageSize: param.pageSize ?? 10,
    tranCode: '',
    startDate: param.startDate ?? '',
    endDate: param.endDate ?? '',
  );
  final res = await RexApi.instance.fetchMiniStatement(
    authToken: authToken ?? '',
    request: request,
  );
  return res.data;
});

final inMemoryRecentTransaction = StateProvider<TransferData>((ref) {
  return TransferData.empty();
});

/// model class added as a parameter to [userRecentTransactionProvider]
class RecentTransactionParam extends Equatable {
  final String? startDate;
  final String? endDate;
  final int? pageIndex;
  final int? pageSize;

  const RecentTransactionParam({
    this.startDate,
    this.endDate,
    this.pageIndex,
    this.pageSize,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        pageIndex,
        pageSize,
      ];
}
