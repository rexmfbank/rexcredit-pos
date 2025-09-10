import 'package:equatable/equatable.dart';

class SecurityQuestion extends Equatable {
  final String questionId;
  final String answer;

  const SecurityQuestion({
    required this.questionId,
    required this.answer,
  });

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
    return SecurityQuestion(
      questionId: json['question_id'] as String,
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "answer": answer,
      };

  @override
  String toString() => {
        "CLASS": "SecurityQuestion",
        "question_id": questionId,
        "answer": answer,
      }.toString();

  @override
  List<Object?> get props => [
        questionId,
        answer,
      ];
}
