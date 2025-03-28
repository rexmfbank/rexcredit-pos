import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/individual/more/models/security_question_form.dart';

class CompleteProfileForm extends Equatable {
  final String dateOfBirth;
  final String gender;
  final String bvn;
  final String residentAddress;
  final String residentState;
  final String residentLga;
  final List<SecurityQuestionForm> questions;
  final String selfie;

  const CompleteProfileForm({
    required this.dateOfBirth,
    required this.gender,
    required this.bvn,
    required this.residentAddress,
    required this.residentState,
    required this.residentLga,
    required this.questions,
    required this.selfie,
  });

  const CompleteProfileForm.empty()
      : dateOfBirth = '',
        gender = '',
        bvn = '',
        residentAddress = '',
        residentState = '',
        residentLga = '',
        questions = const [],
        selfie = '';

  factory CompleteProfileForm.fromJson(Map<String, dynamic> json) {
    return CompleteProfileForm(
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      bvn: json['bvn'],
      residentAddress: json['residential_address'],
      residentState: json['residential_state'],
      residentLga: json['residential_lga'],
      questions: List<SecurityQuestionForm>.from(json['questions'].map(
        (e) => SecurityQuestionForm.fromJson(e),
      )),
      selfie: json['selfie'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;
    map['bvn'] = bvn;
    map['residential_address'] = residentAddress;
    map['residential_state'] = residentState;
    map['residential_lga'] = residentLga;
    map['questions'] = questions.map((e) => e.toJson()).toList();
    map['selfie'] = selfie;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "CompleteProfileForm",
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "bvn": bvn,
      "residentAddress": residentAddress,
      "residentState": residentState,
      "residentLGA": residentLga,
      "questions": questions,
      "selfie": selfie,
    }.toString();
  }

  @override
  List<Object?> get props => [
        dateOfBirth,
        gender,
        residentAddress,
        residentState,
        residentLga,
        selfie,
      ];
}
