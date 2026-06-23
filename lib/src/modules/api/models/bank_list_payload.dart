import 'package:equatable/equatable.dart';

class BankListResponse extends Equatable {
  const BankListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<BankData>? data;

  factory BankListResponse.fromJson(Map<String, dynamic> json) {
    return BankListResponse(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null
              ? []
              : List<BankData>.from(
                json["data"].map((x) => BankData.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [status, message, data];
}

class BankData extends Equatable {
  const BankData({required this.code, required this.name});

  final String? code;
  final String? name;

  factory BankData.fromJson(Map<String, dynamic> json) {
    return BankData(code: json["code"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"code": code, "name": name};

  @override
  List<Object?> get props => [code, name];
}
