import 'package:equatable/equatable.dart';

class SetWithdrawalLimitRequest extends Equatable {
  final String accountNumber;
  final int amount;

  SetWithdrawalLimitRequest(
      {
        required this.accountNumber,
        required this.amount,
      });

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'amount': amount
    };
  }

  @override
  List<Object?> get props => [
        accountNumber,
        amount
      ];
}
