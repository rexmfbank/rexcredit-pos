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
  pending(name: 'Pending', code: 'pending'),
  // paid(name: 'Paid', code: 'paid'),
  failed(name: 'Failed', code: 'failed'),
  success(name: 'Success', code: 'success'),
  all(name: 'All', code: '');

  const PosFilterTransStatus({required this.name, required this.code});

  final String name;
  final String code;
}

enum PosFilterTransCode {
  cardPurchase(name: 'Card Purchase', code: 'CARD_PURCHASE'),
  internalTransfer(name: 'Transfer (Rex)', code: 'ITRA'),
  externalTransfer(name: 'Transfer (Others)', code: 'IBFT'),
  all(name: 'All', code: '');

  const PosFilterTransCode({required this.name, required this.code});
  final String name;
  final String code;
}

final posFilterTransTypeProvider = StateProvider<PosFilterTransType>(
  (ref) => PosFilterTransType.all,
);
final posFilterTransStatusProvider = StateProvider<PosFilterTransStatus>(
  (ref) => PosFilterTransStatus.all,
);

final posFilterTransCodeProvider = StateProvider<PosFilterTransCode>(
  (ref) => PosFilterTransCode.all,
);

final posHasFilterProvider = Provider<bool>((ref) {
  final transType = ref.watch(posFilterTransTypeProvider);
  final transStatus = ref.watch(posFilterTransStatusProvider);
  final transCode = ref.watch(posFilterTransCodeProvider);
  final dateFilter = ref.watch(posTransDateProvider);

  return transType != PosFilterTransType.all ||
      transStatus != PosFilterTransStatus.all ||
      transCode != PosFilterTransCode.all ||
      (dateFilter.startDate != null && dateFilter.endDate != null);
});
