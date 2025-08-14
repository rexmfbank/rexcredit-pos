import 'package:equatable/equatable.dart';

class SetupSecurityForm extends Equatable {
  final SecurityQuestionForm questions;

  const SetupSecurityForm({
    required this.questions,
  });

  const SetupSecurityForm.empty()
      : questions = const SecurityQuestionForm.empty();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questions'] = questions.toJson();
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "SetupSecurityForm",
      "questions": questions,
    }.toString();
  }

  @override
  List<Object?> get props => [questions];
}

class SecurityQuestionForm extends Equatable {
  final String questionId;
  final String answer;

  const SecurityQuestionForm({
    required this.questionId,
    required this.answer,
  });

  const SecurityQuestionForm.empty()
      : questionId = '1',
        answer = 'Lagos';

  factory SecurityQuestionForm.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionForm(
      questionId: json['question_id'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = questionId;
    map['answer'] = answer;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "SecurityQuestion",
      "questionId": questionId,
      "answer": answer,
    }.toString();
  }

  @override
  List<Object?> get props => [questionId, answer];
}
