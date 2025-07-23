import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/dashboard_personal/ui/transactions/refactor/trans_date_notifier.dart';

enum FilterTransactionType {
  credit(name: 'Credit', code: 'credit'),
  debit(name: 'Debit', code: 'debit'),
  all(name: 'All', code: '');

  const FilterTransactionType({required this.name, required this.code});

  final String name;
  final String code;
}

enum FilterTransactionStatus {
  pending(name: 'Pending', code: 'Pending'),
  paid(name: 'Paid', code: 'paid'),
  failed(name: 'Failed', code: 'failed'),
  all(name: 'All', code: '');

  const FilterTransactionStatus({required this.name, required this.code});

  final String name;
  final String code;
}

final selectedTransactionTypeProvider = StateProvider<FilterTransactionType>(
  (ref) => FilterTransactionType.all,
);
final selectedTransactionStatusProvider =
    StateProvider<FilterTransactionStatus>(
      (ref) => FilterTransactionStatus.all,
    );

final hasFilterProvider = Provider<bool>((ref) {
  final transactionType = ref.watch(selectedTransactionTypeProvider);
  final status = ref.watch(selectedTransactionStatusProvider);
  final dateFilter = ref.watch(transactionDateProvider);

  return transactionType != FilterTransactionType.all ||
      status != FilterTransactionStatus.all ||
      (dateFilter.startDate != null && dateFilter.endDate != null);
});
