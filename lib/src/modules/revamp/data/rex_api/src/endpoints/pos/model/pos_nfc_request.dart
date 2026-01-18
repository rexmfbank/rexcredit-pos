import 'package:equatable/equatable.dart';

class PosNfcRequest extends Equatable {
  final String terminalId;
  final double amount;
  final String rrn;
  final String stan;
  final String datetime;
  final String cardPayload;
  final String pin;

  const PosNfcRequest({
    required this.terminalId,
    required this.amount,
    required this.rrn,
    required this.stan,
    required this.datetime,
    required this.cardPayload,
    required this.pin,
  });

  factory PosNfcRequest.fromJson(Map<String, dynamic> json) {
    return PosNfcRequest(
      terminalId: json['terminal_id'],
      amount: json['amount'],
      rrn: json['rrn'],
      stan: json['stan'],
      datetime: json['datetime'],
      cardPayload: json['card_payload'],
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "terminal_id": "TERM-1",
      "amount": 1500,
      "rrn": "1234567890",
      "stan": "654321",
      "datetime": "2025-01-01 10:00",
      "card_payload": "REX|v1|0123456789abcdef0123456789abcdef",
      "pin": "1234",
    };
  }

  @override
  String toString() => "PosNfcRequest ${toString()}";

  @override
  List<Object?> get props => [
    terminalId,
    amount,
    rrn,
    stan,
    datetime,
    cardPayload,
    pin,
  ];
}

class PosNfcResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic entityCode;
  final dynamic data;

  const PosNfcResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  factory PosNfcResponse.fromJson(Map<String, dynamic> json) {
    return PosNfcResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "response_code": responseCode,
      "response_messsage": responseMessage,
      "entity_code": entityCode,
      "data": data,
    };
  }

  @override
  String toString() => "PosNfcResponse ${toString()}";

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}
