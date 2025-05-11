import 'package:equatable/equatable.dart';

class InternalBalanceEnquiryRequest extends Equatable {
  final String bankCode;
  final String accountNumber;

  const InternalBalanceEnquiryRequest({
    required this.bankCode,
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "accountNumber": accountNumber,
      };

  @override
  List<Object?> get props => [
        bankCode,
        accountNumber,
      ];
}
