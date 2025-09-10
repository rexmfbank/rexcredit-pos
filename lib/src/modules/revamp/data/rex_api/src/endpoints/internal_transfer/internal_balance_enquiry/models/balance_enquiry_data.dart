import 'package:equatable/equatable.dart';

class BalanceEnquiryData extends Equatable {
  final String accountNumber;
  final String name;
  final num ledgerBalance;
  final double availableBalance;

  const BalanceEnquiryData({
    required this.accountNumber,
    required this.name,
    required this.ledgerBalance,
    required this.availableBalance,
  });

  const BalanceEnquiryData.empty()
    : accountNumber = '',
      name = '',
      ledgerBalance = 0.0,
      availableBalance = 0.0;

  factory BalanceEnquiryData.fromJson(Map<String, dynamic> json) {
    return BalanceEnquiryData(
      accountNumber: json['accountNumber'] as String,
      name: json['name'] as String,
      ledgerBalance: json["legerBalance"],
      availableBalance: json['availableBalance'] as double,
    );
  }

  @override
  List<Object?> get props => [
    accountNumber,
    name,
    ledgerBalance,
    availableBalance,
  ];
}
