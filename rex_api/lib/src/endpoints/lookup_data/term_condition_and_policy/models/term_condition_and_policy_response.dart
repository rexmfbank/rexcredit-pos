import 'package:equatable/equatable.dart';

class TermsConditionsAndPolicyResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String termsAndConditions;
  final String privacyPolicy;


  TermsConditionsAndPolicyResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.termsAndConditions,
    required this.privacyPolicy
  });

  TermsConditionsAndPolicyResponse.empty()
      : responseCode = '',
        responseMessage = '',
        termsAndConditions = '',
        privacyPolicy = '';

  factory TermsConditionsAndPolicyResponse.fromJson(Map<String, dynamic> json) {
    return TermsConditionsAndPolicyResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      termsAndConditions: json["termsAndConditions"],
      privacyPolicy: json['privacyPolicy']
    );
  }

  @override
  List<Object?> get props => [
    responseCode,
    responseMessage,
    termsAndConditions,
    privacyPolicy
  ];
}
