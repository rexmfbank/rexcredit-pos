import 'package:equatable/equatable.dart';

class NameInquiryRequest extends Equatable {
  const NameInquiryRequest({
    required this.accountNumber,
    required this.bankCode,
    required this.borrowerID,
  });

  final String? accountNumber;
  final String? bankCode;
  final String? borrowerID;

  factory NameInquiryRequest.fromJson(Map<String, dynamic> json) {
    return NameInquiryRequest(
      accountNumber: json["account_number"],
      bankCode: json["bank_code"],
      borrowerID: json['borrower_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "bank_code": bankCode,
    "borrower_id": borrowerID,
  };

  @override
  List<Object?> get props => [accountNumber, bankCode, borrowerID];
}

class NameInquiryResponse extends Equatable {
  const NameInquiryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final NameInquiryData? data;

  factory NameInquiryResponse.fromJson(Map<String, dynamic> json) {
    return NameInquiryResponse(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null ? null : NameInquiryData.fromJson(json["data"]),
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

class NameInquiryData extends Equatable {
  const NameInquiryData({
    required this.recipientCode,
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
    required this.providerResponse,
  });

  final String? recipientCode;
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;
  final ProviderResponse? providerResponse;

  factory NameInquiryData.fromJson(Map<String, dynamic> json) {
    return NameInquiryData(
      recipientCode: json["recipient_code"],
      accountNumber: json["account_number"],
      accountName: json["account_name"],
      bankCode: json["bank_code"],
      bankName: json["bank_name"],
      providerResponse:
          json["provider_response"] == null
              ? null
              : ProviderResponse.fromJson(json["provider_response"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "recipient_code": recipientCode,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_code": bankCode,
    "bank_name": bankName,
    "provider_response": providerResponse?.toJson(),
  };

  @override
  List<Object?> get props => [
    recipientCode,
    accountNumber,
    accountName,
    bankCode,
    bankName,
    providerResponse,
  ];
}

class ProviderResponse extends Equatable {
  const ProviderResponse({
    required this.accountName,
    required this.recipientCode,
    required this.details,
  });

  final String? accountName;
  final String? recipientCode;
  final ProviderResponseDetails? details;

  factory ProviderResponse.fromJson(Map<String, dynamic> json) {
    return ProviderResponse(
      accountName: json["accountName"],
      recipientCode: json["recipient_code"],
      details:
          json["details"] == null
              ? null
              : ProviderResponseDetails.fromJson(json["details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "accountName": accountName,
    "recipient_code": recipientCode,
    "details": details?.toJson(),
  };

  @override
  List<Object?> get props => [accountName, recipientCode, details];
}

class ProviderResponseDetails extends Equatable {
  const ProviderResponseDetails({
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
  });

  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;

  factory ProviderResponseDetails.fromJson(Map<String, dynamic> json) {
    return ProviderResponseDetails(
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
