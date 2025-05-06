import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class ReprintState extends Equatable {
  final String todaysDate;
  final List<TransferData> transactionList;
  final List<TransferData> todaysList;

  const ReprintState({
    required this.todaysDate,
    required this.transactionList,
    required this.todaysList,
  });

  ReprintState copyWith({
    String? todaysDate,
    List<TransferData>? transactionList,
    List<TransferData>? todaysList,
  }) {
    return ReprintState(
      todaysDate: todaysDate ?? this.todaysDate,
      transactionList: transactionList ?? this.transactionList,
      todaysList: todaysList ?? this.todaysList,
    );
  }

  @override
  List<Object?> get props => [
        todaysDate,
        transactionList,
        todaysList,
      ];
}
