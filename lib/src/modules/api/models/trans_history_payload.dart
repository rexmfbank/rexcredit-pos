import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/api/models/get_balance_payload.dart';

class TransHistoryRequest extends Equatable {
  const TransHistoryRequest({required this.accountNumber});

  final String? accountNumber;

  factory TransHistoryRequest.fromJson(Map<String, dynamic> json) {
    return TransHistoryRequest(accountNumber: json["account_number"]);
  }

  Map<String, dynamic> toJson() => {"account_number": accountNumber};

  @override
  List<Object?> get props => [accountNumber];
}

class TransHistoryResponse extends Equatable {
  const TransHistoryResponse({
    required this.status,
    required this.message,
    this.data,
  });

  final String status;
  final String message;
  final TData? data;

  factory TransHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransHistoryResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : TData.fromJson(json["data"]),
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}

class TData extends Equatable {
  const TData({this.accountNumber, this.availableBalance, this.transactions});

  final String? accountNumber;
  final String? availableBalance;
  final TDataTransactions? transactions;

  factory TData.fromJson(Map<String, dynamic> json) {
    return TData(
      accountNumber: json["account_number"],
      availableBalance: json["available_balance"],
      transactions:
          json["transactions"] == null
              ? null
              : TDataTransactions.fromJson(json["transactions"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "available_balance": availableBalance,
    "transactions": transactions?.toJson(),
  };

  @override
  List<Object?> get props => [accountNumber, availableBalance, transactions];
}

class TDataTransactions extends Equatable {
  const TDataTransactions({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final num? currentPage;
  final List<Transaction> data;
  final String? firstPageUrl;
  final num? from;
  final num? lastPage;
  final String? lastPageUrl;
  final dynamic links;
  final String? nextPageUrl;
  final String? path;
  final num? perPage;
  final String? prevPageUrl;
  final num? to;
  final num? total;

  factory TDataTransactions.fromJson(Map<String, dynamic> json) {
    return TDataTransactions(
      currentPage: json["current_page"],
      data:
          json["data"] == null
              ? []
              : List<Transaction>.from(
                json["data"].map((x) => Transaction.fromJson(x)),
              ),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"],
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x.toJson()).toList(),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

  @override
  List<Object?> get props => [
    currentPage,
    data,
    firstPageUrl,
    from,
    lastPage,
    lastPageUrl,
    links,
    nextPageUrl,
    path,
    perPage,
    prevPageUrl,
    to,
    total,
  ];
}
