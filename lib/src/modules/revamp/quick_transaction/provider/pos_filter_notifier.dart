import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/provider/pos_trans_date_notifier.dart';

enum PosFilterTransType {
  credit(name: 'Credit', code: 'credit'),
  debit(name: 'Debit', code: 'debit'),
  all(name: 'All', code: '');

  const PosFilterTransType({required this.name, required this.code});

  final String name;
  final String code;
}

enum PosFilterTransStatus {
  pending(name: 'Pending', code: 'Pending'),
  paid(name: 'Paid', code: 'paid'),
  failed(name: 'Failed', code: 'failed'),
  all(name: 'All', code: '');

  const PosFilterTransStatus({required this.name, required this.code});

  final String name;
  final String code;
}

final posFilterTransTypeProvider = StateProvider<PosFilterTransType>(
  (ref) => PosFilterTransType.all,
);
final posFilterTransStatusProvider = StateProvider<PosFilterTransStatus>(
  (ref) => PosFilterTransStatus.all,
);

final posHasFilterProvider = Provider<bool>((ref) {
  final transactionType = ref.watch(posFilterTransTypeProvider);
  final status = ref.watch(posFilterTransStatusProvider);
  final dateFilter = ref.watch(posTransDateProvider);

  return transactionType != PosFilterTransType.all ||
      status != PosFilterTransStatus.all ||
      (dateFilter.startDate != null && dateFilter.endDate != null);
});
