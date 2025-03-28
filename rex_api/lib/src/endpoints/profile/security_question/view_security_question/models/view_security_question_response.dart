import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/profile/security_question/view_security_question/models/security_question_data.dart';

class ViewSecurityQuestionResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final SecurityQuestionData data;

  ViewSecurityQuestionResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory ViewSecurityQuestionResponse.fromJson(Map<String, dynamic> json) {
    return ViewSecurityQuestionResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: SecurityQuestionData.fromJson(json['data']),
    );
  }
}
