import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';

class ReprintState extends Equatable {
  final String todaysDate;
  final String startDate;
  final String endDate;
  final List<TransferData> transactionList;
  final List<TransferData> todaysList;
  final List<PosTransactionsResponseData> posTransactList;

  const ReprintState({
    required this.todaysDate,
    required this.startDate,
    required this.endDate,
    required this.transactionList,
    required this.todaysList,
    required this.posTransactList,
  });

  ReprintState copyWith({
    String? todaysDate,
    String? startDate,
    String? endDate,
    List<TransferData>? transactionList,
    List<TransferData>? todaysList,
    List<PosTransactionsResponseData>? posTransactList,
  }) {
    return ReprintState(
      todaysDate: todaysDate ?? this.todaysDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      transactionList: transactionList ?? this.transactionList,
      todaysList: todaysList ?? this.todaysList,
      posTransactList: posTransactList ?? this.posTransactList,
    );
  }

  @override
  List<Object?> get props => [
    todaysDate,
    startDate,
    endDate,
    transactionList,
    todaysList,
    posTransactList,
  ];
}
