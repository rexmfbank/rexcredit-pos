import 'package:equatable/equatable.dart';

class RetrieveRrnRequest extends Equatable {
  final num amount;
  final String terminalId;
  final String transactionType;

  const RetrieveRrnRequest({
    required this.amount,
    required this.terminalId,
    required this.transactionType,
  });

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "terminalID": terminalId,
        "transactionType": transactionType,
      };

  @override
  List<Object?> get props => [amount, terminalId, transactionType];
}
