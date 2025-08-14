import 'package:equatable/equatable.dart';

class SecurityQuestion extends Equatable {
  final int id;
  final String question;

  const SecurityQuestion({
    required this.id,
    required this.question,
  });

  const SecurityQuestion.empty()
      : id = 0,
        question = '';

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
    return SecurityQuestion(
      id: json['id'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "SecurityQuestion",
      "id": id,
      "question": question,
    }.toString();
  }

  @override
  List<Object?> get props => [id, question];
}
