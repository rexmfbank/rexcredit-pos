import 'package:equatable/equatable.dart';

class GetBalanceResponse extends Equatable {
  const GetBalanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final BalanceData? data;

  factory GetBalanceResponse.fromJson(Map<String, dynamic> json) {
    return GetBalanceResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : BalanceData.fromJson(json["data"]),
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

class BalanceData extends Equatable {
  const BalanceData({required this.balances});

  final List<Balance> balances;

  factory BalanceData.fromJson(Map<String, dynamic> json) {
    return BalanceData(
      balances:
          json["balances"] == null
              ? []
              : List<Balance>.from(
                json["balances"]!.map((x) => Balance.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "balances": balances.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [balances];
}

class Balance extends Equatable {
  const Balance({
    required this.accountName,
    required this.accountType,
    required this.accountNumber,
    required this.availableBalance,
  });

  final String? accountName;
  final String? accountType;
  final String? accountNumber;
  final String? availableBalance;

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      accountName: json["account_name"],
      accountType: json["account_type"],
      accountNumber: json["account_number"],
      availableBalance: json["available_balance"],
    );
  }

  Map<String, dynamic> toJson() => {
    "account_name": accountName,
    "account_type": accountType,
    "account_number": accountNumber,
    "available_balance": availableBalance,
  };

  @override
  List<Object?> get props => [
    accountName,
    accountType,
    accountNumber,
    availableBalance,
  ];
}

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.reference,
    required this.instrumentNo,
    required this.data,
    required this.latitude,
    required this.longitude,
    required this.companyId,
    required this.branchId,
    required this.borrowerId,
    required this.savingsId,
    required this.transactionAmount,
    required this.balance,
    required this.transactionDate,
    required this.transactionTime,
    required this.effectiveAt,
    required this.postedAt,
    required this.amountSigned,
    required this.balanceAfter,
    required this.reversesTransactionId,
    required this.transactionType,
    required this.transactionDescription,
    required this.debit,
    required this.credit,
    required this.statusId,
    required this.coa,
    required this.receipt,
    required this.rates,
    required this.currency,
    required this.externalTxId,
    required this.externalResponse,
    required this.comment,
    required this.channel,
    required this.createdAt,
    required this.updatedAt,
    required this.staffId,
    required this.deletedAt,
    required this.provider,
    required this.category,
    required this.details,
    required this.treasuryTransferDetails,
    required this.currencyPair,
  });

  final int? id;
  final String? reference;
  final dynamic instrumentNo;
  final dynamic data;
  final dynamic latitude;
  final dynamic longitude;
  final int? companyId;
  final int? branchId;
  final int? borrowerId;
  final int? savingsId;
  final String? transactionAmount;
  final String? balance;
  final DateTime? transactionDate;
  final String? transactionTime;
  final DateTime? effectiveAt;
  final DateTime? postedAt;
  final String? amountSigned;
  final String? balanceAfter;
  final dynamic reversesTransactionId;
  final String? transactionType;
  final String? transactionDescription;
  final String? debit;
  final String? credit;
  final String? statusId;
  final dynamic coa;
  final dynamic receipt;
  final dynamic rates;
  final dynamic currency;
  final dynamic externalTxId;
  final dynamic externalResponse;
  final dynamic comment;
  final String? channel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic staffId;
  final dynamic deletedAt;
  final dynamic provider;
  final String? category;
  final dynamic details;
  final dynamic treasuryTransferDetails;
  final dynamic currencyPair;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      reference: json["reference"],
      instrumentNo: json["instrument_no"],
      data: json["data"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      companyId: json["company_id"],
      branchId: json["branch_id"],
      borrowerId: json["borrower_id"],
      savingsId: json["savings_id"],
      transactionAmount: json["transaction_amount"],
      balance: json["balance"],
      transactionDate: DateTime.tryParse(json["transaction_date"] ?? ""),
      transactionTime: json["transaction_time"],
      effectiveAt: DateTime.tryParse(json["effective_at"] ?? ""),
      postedAt: DateTime.tryParse(json["posted_at"] ?? ""),
      amountSigned: json["amount_signed"],
      balanceAfter: json["balance_after"],
      reversesTransactionId: json["reverses_transaction_id"],
      transactionType: json["transaction_type"],
      transactionDescription: json["transaction_description"],
      debit: json["debit"],
      credit: json["credit"],
      statusId: json["status_id"],
      coa: json["coa"],
      receipt: json["receipt"],
      rates: json["rates"],
      currency: json["currency"],
      externalTxId: json["external_tx_id"],
      externalResponse: json["external_response"],
      comment: json["comment"],
      channel: json["channel"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      staffId: json["staff_id"],
      deletedAt: json["deleted_at"],
      provider: json["provider"],
      category: json["category"],
      details: json["details"],
      treasuryTransferDetails: json["treasury_transfer_details"],
      currencyPair: json["currency_pair"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "instrument_no": instrumentNo,
    "data": data,
    "latitude": latitude,
    "longitude": longitude,
    "company_id": companyId,
    "branch_id": branchId,
    "borrower_id": borrowerId,
    "savings_id": savingsId,
    "transaction_amount": transactionAmount,
    "balance": balance,
    "transaction_date": transactionDate?.toIso8601String(),
    "transaction_time": transactionTime,
    "effective_at": effectiveAt?.toIso8601String(),
    "posted_at": postedAt?.toIso8601String(),
    "amount_signed": amountSigned,
    "balance_after": balanceAfter,
    "reverses_transaction_id": reversesTransactionId,
    "transaction_type": transactionType,
    "transaction_description": transactionDescription,
    "debit": debit,
    "credit": credit,
    "status_id": statusId,
    "coa": coa,
    "receipt": receipt,
    "rates": rates,
    "currency": currency,
    "external_tx_id": externalTxId,
    "external_response": externalResponse,
    "comment": comment,
    "channel": channel,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "staff_id": staffId,
    "deleted_at": deletedAt,
    "provider": provider,
    "category": category,
    "details": details,
    "treasury_transfer_details": treasuryTransferDetails,
    "currency_pair": currencyPair,
  };

  @override
  List<Object?> get props => [
    id,
    reference,
    instrumentNo,
    data,
    latitude,
    longitude,
    companyId,
    branchId,
    borrowerId,
    savingsId,
    transactionAmount,
    balance,
    transactionDate,
    transactionTime,
    effectiveAt,
    postedAt,
    amountSigned,
    balanceAfter,
    reversesTransactionId,
    transactionType,
    transactionDescription,
    debit,
    credit,
    statusId,
    coa,
    receipt,
    rates,
    currency,
    externalTxId,
    externalResponse,
    comment,
    channel,
    createdAt,
    updatedAt,
    staffId,
    deletedAt,
    provider,
    category,
    details,
    treasuryTransferDetails,
    currencyPair,
  ];
}
