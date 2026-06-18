import 'package:equatable/equatable.dart';

class PosCardPurchaseResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic entityCode;
  final dynamic data;

  const PosCardPurchaseResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  factory PosCardPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PosCardPurchaseResponse(
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
