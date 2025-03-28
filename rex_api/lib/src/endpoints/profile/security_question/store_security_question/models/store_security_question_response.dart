import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/profile/security_question/view_security_question/models/security_question_data.dart';

class StoreSecurityQuestionResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final SecurityQuestionData? data;

  StoreSecurityQuestionResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  StoreSecurityQuestionResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = '',
        data = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory StoreSecurityQuestionResponse.fromJson(Map<String, dynamic> json) {
    return StoreSecurityQuestionResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json['data'] != null
        ? SecurityQuestionData.fromJson(json['data'])
        : null,
    );
  }
}
