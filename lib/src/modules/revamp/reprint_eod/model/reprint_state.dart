import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class ReprintState extends Equatable {
  final String todaysDate;
  final List<TransferData> transactionList;
  final List<TransferData> todaysList;
  final List<PosTransactionsResponseData> posTransactList;

  const ReprintState({
    required this.todaysDate,
    required this.transactionList,
    required this.todaysList,
    required this.posTransactList,
  });

  ReprintState copyWith({
    String? todaysDate,
    List<TransferData>? transactionList,
    List<TransferData>? todaysList,
    List<PosTransactionsResponseData>? posTransactList,
  }) {
    return ReprintState(
      todaysDate: todaysDate ?? this.todaysDate,
      transactionList: transactionList ?? this.transactionList,
      todaysList: todaysList ?? this.todaysList,
      posTransactList: posTransactList ?? this.posTransactList,
    );
  }

  @override
  List<Object?> get props => [
    todaysDate,
    transactionList,
    todaysList,
    posTransactList,
  ];
}
