import 'package:equatable/equatable.dart';

class LoanRepaymentRequest extends Equatable {
  final String amount;
  final String note;
  final String fundingSource;
  final String fundingSourceId;
  final bool terminate;

  const LoanRepaymentRequest({
    required this.amount,
    required this.note,
    required this.fundingSource,
    required this.fundingSourceId,
    required this.terminate,
  });

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "note": note,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "terminate": terminate
      };

  @override
  String toString() => {
        "CLASS": "LoanRepaymentRequest",
        "amount": amount,
        "note": note,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "terminate": terminate
      }.toString();

  @override
  List<Object?> get props => [
        amount,
        note,
        fundingSource,
        fundingSourceId,
        terminate,
      ];
}
