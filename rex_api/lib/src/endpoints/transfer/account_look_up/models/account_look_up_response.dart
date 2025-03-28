import 'package:equatable/equatable.dart';

class AccountLookUpResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final InternalAccountLookUpData? data;

  AccountLookUpResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data
  });

  AccountLookUpResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory AccountLookUpResponse.fromJson(Map<String, dynamic> json) {
    return AccountLookUpResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
        data: json['data'] == null ? null : InternalAccountLookUpData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [
    responseCode,
    responseMessage,
    data
  ];
}

class InternalAccountLookUpData extends Equatable {
  final String? accountNumber;
  final String? name;
  

  const InternalAccountLookUpData({
    this.accountNumber,
    this.name,
  });

  const InternalAccountLookUpData.empty()
      : accountNumber = null,
        name = null;

  factory InternalAccountLookUpData.fromJson(Map<String, dynamic> json) {
    return InternalAccountLookUpData(
      accountNumber: json['accountNumber'] as String?,
      name: json['name'] as String?,
    );
  }

  @override
  String toString() => {
        "CLASS": "InternalAccountLookUpData",
        "accountNumber": accountNumber,
        "name": name,
      }.toString();

  @override
  List<Object?> get props => [
        accountNumber,
        name,
      ];
}