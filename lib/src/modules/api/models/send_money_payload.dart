import 'package:equatable/equatable.dart';

class SendMoneyRequest extends Equatable {
  const SendMoneyRequest({
    required this.amount,
    required this.recipientCode,
    required this.narration,
    required this.accountNumber,
    required this.borrowerId,
    required this.pin,
  });

  final String? amount;
  final String? recipientCode;
  final String? narration;
  final String? accountNumber;
  final int? borrowerId;
  final String? pin;

  factory SendMoneyRequest.fromJson(Map<String, dynamic> json) {
    return SendMoneyRequest(
      amount: json["amount"],
      recipientCode: json["recipient_code"],
      narration: json["narration"],
      accountNumber: json["account_number"],
      borrowerId: json["borrower_id"],
      pin: json["pin"],
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "recipient_code": recipientCode,
    "narration": narration,
    "account_number": accountNumber,
    "borrower_id": borrowerId,
    "pin": pin,
  };

  @override
  List<Object?> get props => [
    amount,
    recipientCode,
    narration,
    accountNumber,
    borrowerId,
    pin,
  ];
}

class SendMoneyResponse extends Equatable {
  const SendMoneyResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final SendMoneyResponseData? data;

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) {
    return SendMoneyResponse(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null
              ? null
              : SendMoneyResponseData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  List<Object?> get props => [status, message, data];
}

class SendMoneyResponseData extends Equatable {
  const SendMoneyResponseData({required this.data});

  final SendMoneyData? data;

  factory SendMoneyResponseData.fromJson(Map<String, dynamic> json) {
    return SendMoneyResponseData(
      data:
          json["data"] == null
              ? null
              : SendMoneyData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {"data": data?.toJson()};

  @override
  List<Object?> get props => [data];
}

class SendMoneyData extends Equatable {
  const SendMoneyData({
    required this.reference,
    required this.status,
    required this.amount,
    required this.beneficiaryAccount,
    required this.narration,
    required this.createdAt,
    required this.message,
    required this.beneficiary,
  });

  final String? reference;
  final String? status;
  final num? amount;
  final String? beneficiaryAccount;
  final String? narration;
  final DateTime? createdAt;
  final String? message;
  final SendMoneyBeneficiary? beneficiary;

  factory SendMoneyData.fromJson(Map<String, dynamic> json) {
    return SendMoneyData(
      reference: json["reference"],
      status: json["status"],
      amount: json["amount"],
      beneficiaryAccount: json["beneficiary_account"],
      narration: json["narration"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      message: json["message"],
      beneficiary:
          json["beneficiary"] == null
              ? null
              : SendMoneyBeneficiary.fromJson(json["beneficiary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "status": status,
    "amount": amount,
    "beneficiary_account": beneficiaryAccount,
    "narration": narration,
    "created_at": createdAt?.toIso8601String(),
    "message": message,
    "beneficiary": beneficiary?.toJson(),
  };

  @override
  List<Object?> get props => [
    reference,
    status,
    amount,
    beneficiaryAccount,
    narration,
    createdAt,
    message,
    beneficiary,
  ];
}

class SendMoneyBeneficiary extends Equatable {
  const SendMoneyBeneficiary({
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
  });

  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;

  factory SendMoneyBeneficiary.fromJson(Map<String, dynamic> json) {
    return SendMoneyBeneficiary(
      accountNumber: json["account_number"],
      accountName: json["account_name"],
      bankCode: json["bank_code"],
      bankName: json["bank_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_code": bankCode,
    "bank_name": bankName,
  };

  @override
  List<Object?> get props => [accountNumber, accountName, bankCode, bankName];
}
