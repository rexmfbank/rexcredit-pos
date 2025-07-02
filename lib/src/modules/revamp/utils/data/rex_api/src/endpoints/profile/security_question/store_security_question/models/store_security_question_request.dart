import 'package:equatable/equatable.dart';

class StoreSecurityQuestionRequest extends Equatable {
  final String question;
  final String answer;

  const StoreSecurityQuestionRequest({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };

  @override
  List<Object?> get props => [
        question,
        answer
      ];
}
