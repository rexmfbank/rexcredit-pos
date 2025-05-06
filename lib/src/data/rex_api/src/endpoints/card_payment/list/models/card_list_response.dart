import 'package:equatable/equatable.dart';
import 'debit_card_data.dart';

class CardListResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final List<DebitCardData> data;

  const CardListResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const CardListResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = const [];

  factory CardListResponse.fromJson(Map<String, dynamic> json) {
    return CardListResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: List<DebitCardData>.from(
        json['data'].map((e) => DebitCardData.fromJson(e)),
      ),
    );
  }

  @override
  String toString() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
