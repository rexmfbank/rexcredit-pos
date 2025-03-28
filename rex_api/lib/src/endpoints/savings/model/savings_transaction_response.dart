import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/savings/model/savings_transaction_data.dart';

class SavingsTransactionResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? entityCode;
  final List<SavingsTransactionData>? data;

  const SavingsTransactionResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const SavingsTransactionResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = null;

  factory SavingsTransactionResponse.fromJson(Map<String, dynamic> json) {
    return SavingsTransactionResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'] == null
          ? null
          : List.from(json['data'].map(
              (e) => SavingsTransactionData.fromJson(e),
            )),
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsTransactionData",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];
}
