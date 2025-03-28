import 'package:equatable/equatable.dart';

class SaveBeneficiaryResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final dynamic data;

  const SaveBeneficiaryResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data
  });

  SaveBeneficiaryResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory SaveBeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    return SaveBeneficiaryResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'],
    );
  }

  @override
  String toString() => {
        "CLASS": "SaveBeneficiaryResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
