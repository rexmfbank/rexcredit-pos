import 'package:equatable/equatable.dart';

class PosAuthResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final PosAuthResponseData data;

  const PosAuthResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  factory PosAuthResponse.fromJson(Map<String, dynamic> json) {
    return PosAuthResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: PosAuthResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() =>
      {
        "CLASS": "PosAuthResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class PosAuthResponseData extends Equatable {
  final String secret;
  final String accountNo;
  final String accountName;
  final String terminalId;

  const PosAuthResponseData({
    required this.secret,
    required this.accountNo,
    required this.accountName,
    required this.terminalId,
  });

  factory PosAuthResponseData.fromJson(Map<String, dynamic> json) {
    return PosAuthResponseData(
      secret: json['secret'],
      accountNo: json['accountNo'],
      accountName: json['accountName'],
      terminalId: json['terminalId'],
    );
  }

  @override
  String toString() {
    return "PosAuthResponseData: $secret, $accountNo, $accountName, $terminalId";
  }

  @override
  List<Object?> get props => [secret, accountNo, accountName, terminalId];
}
