import 'package:equatable/equatable.dart';
import 'security_question_data.dart';

class ViewSecurityQuestionResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final SecurityQuestionData data;

  const ViewSecurityQuestionResponse({
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
