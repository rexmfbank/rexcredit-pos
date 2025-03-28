import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/savings/model/create_saving_response_data.dart';

class CreateSavingsResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final CreateSavingResponseData? data;

  const CreateSavingsResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const CreateSavingsResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = const CreateSavingResponseData.empty();

  factory CreateSavingsResponse.fromJson(Map<String, dynamic> json) {
    return CreateSavingsResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'] == null ? null : CreateSavingResponseData.fromJson(json['data']),
    );
  }

  @override
  String toString() => {
        "CLASS": "CreateSavingsResponse",
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
