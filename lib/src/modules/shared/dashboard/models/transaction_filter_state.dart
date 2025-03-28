import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class TransactionFilterState extends Equatable {
  final List<TransferData> transactionList;

  const TransactionFilterState({
    required this.transactionList,
  });

  TransactionFilterState copyWith({
    List<TransferData>? transactionList,
  }) {
    return TransactionFilterState(
      transactionList: transactionList ?? this.transactionList,
    );
  }

  @override
  List<Object?> get props => [transactionList];
}
