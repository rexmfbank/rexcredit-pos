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
  final bool tippingEnabled;
  final String status;
  final String appVersionTerminal;
  final String appVersionMin;

  const PosAuthResponseData({
    required this.secret,
    required this.accountNo,
    required this.accountName,
    required this.terminalId,
    required this.tippingEnabled,
    required this.status,
    required this.appVersionTerminal,
    required this.appVersionMin,
  });

  factory PosAuthResponseData.fromJson(Map<String, dynamic> json) {
    return PosAuthResponseData(
      secret: json['secret'],
      accountNo: json['accountNo'],
      accountName: json['accountName'],
      terminalId: json['terminalId'],
      tippingEnabled: json['tippingEnabled'],
      status: json['status'],
      appVersionTerminal: json['terminal_app_version'],
      appVersionMin: json['min_app_version'],
    );
    // min_app_version is for admin , terminal_app_version is for apk
  }

  @override
  String toString() =>
      {
        "CLASS": "PosAuthResponseData",
        "secret": secret,
        "accountNo": accountNo,
        "accountName": accountName,
        "terminalId": terminalId,
        "tippingEnabled": tippingEnabled,
        "status": status,
        "appVersionTerminal": appVersionTerminal,
        "appVersionMin": appVersionMin,
      }.toString();

  @override
  List<Object?> get props => [
    secret,
    accountNo,
    accountName,
    terminalId,
    tippingEnabled,
    status,
    appVersionTerminal,
    appVersionMin,
  ];
}
