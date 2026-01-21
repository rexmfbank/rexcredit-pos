import 'package:equatable/equatable.dart';

class PosNfcRequest extends Equatable {
  final String terminalId;
  final num amount;
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
      "terminal_id": terminalId,
      "amount": amount,
      "rrn": rrn,
      "stan": stan,
      "datetime": datetime,
      "card_payload": cardPayload,
      "pin": pin,
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

  const PosNfcResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  factory PosNfcResponse.fromJson(Map<String, dynamic> json) {
    return PosNfcResponse(
      responseCode: json['statusCode'],
      responseMessage: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "response_code": responseCode,
      "response_messsage": responseMessage,
    };
  }

  @override
  String toString() => "PosNfcResponse ${toString()}";

  @override
  List<Object?> get props => [responseCode, responseMessage];
}
