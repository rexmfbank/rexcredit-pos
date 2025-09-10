import 'package:equatable/equatable.dart';

class AccountLookUpRequest extends Equatable {
  final String bankCode;
  final String? bankName;
  final String? finEntityType;
  final String accountNumber;
  final String? accountType;
  final String? provider;

  const AccountLookUpRequest({
    required this.bankCode,
    this.bankName,
    this.finEntityType,
    required this.accountNumber,
    this.accountType,
    this.provider,
  });

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,
        "finEntityType": finEntityType,
        "accountNumber": accountNumber,
        "accountType": accountType,
        "provider": provider,
      };

  @override
  List<Object?> get props => [
        bankCode,
        bankName,
        finEntityType,
        accountNumber,
        accountType,
        provider,
      ];
}
