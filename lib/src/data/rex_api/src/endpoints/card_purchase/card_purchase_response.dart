import 'package:equatable/equatable.dart';

class CardPurchaseResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic entityCode;
  final dynamic data;

  const CardPurchaseResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  factory CardPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return CardPurchaseResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      entityCode: json['entityCode'],
      data: json['data'],
    );
  }

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
