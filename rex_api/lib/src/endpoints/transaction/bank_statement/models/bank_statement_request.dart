import 'package:equatable/equatable.dart';

class BankStatementRequest extends Equatable {
  final String startDate;
  final String endDate;
  final String accountNumber;
  final String username;
  final String format;

  const BankStatementRequest({
    required this.startDate,
    required this.endDate,
    required this.accountNumber,
    required this.username,
    required this.format,
  });

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "accountNo": accountNumber,
        "username": username,
        "format": format,
      };

  @override
  String toString() => "BankStatementRequest: ${toJson()}";

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        accountNumber,
        username,
        format,
      ];
}
