import 'package:equatable/equatable.dart';

class SecurityQuestionData extends Equatable {
  final String? questionId;
  final String question;
  final String entityCode;
  final String answer;

  SecurityQuestionData(
      {
        this.questionId,
        required this.entityCode,
        required this.question,
        required this.answer,
      });

  factory SecurityQuestionData.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionData(
      entityCode: json['entityCode'] as String,
      questionId: json['questionId'] as String?,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  @override
  List<Object?> get props => [
        question,
        entityCode,
        questionId,
        answer,
      ];
}
