import 'package:equatable/equatable.dart';

class SecurityQuestionApiResponse extends Equatable {
  final String status;
  final String message;
  final SecurityQuestionData data;

  const SecurityQuestionApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  const SecurityQuestionApiResponse.empty()
      : status = '',
        message = '',
        data = const SecurityQuestionData.empty();

  factory SecurityQuestionApiResponse.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionApiResponse(
      status: json['status'],
      message: json['message'],
      data: SecurityQuestionData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}

class SecurityQuestionData extends Equatable {
  final SecurityQuestionStatus status;

  const SecurityQuestionData({
    required this.status,
  });

  const SecurityQuestionData.empty()
      : status = const SecurityQuestionStatus.empty();

  factory SecurityQuestionData.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionData(
      status: SecurityQuestionStatus.fromJson(json['status']),
    );
  }

  @override
  List<Object?> get props => [status];
}

class SecurityQuestionStatus extends Equatable {
  final bool otp;
  final bool security;
  final bool profile;

  const SecurityQuestionStatus({
    required this.otp,
    required this.security,
    required this.profile,
  });

  const SecurityQuestionStatus.empty()
      : otp = false,
        security = false,
        profile = false;

  factory SecurityQuestionStatus.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionStatus(
      otp: json['otp'],
      security: json['security'],
      profile: json['profile'],
    );
  }

  @override
  List<Object?> get props => [otp, security, profile];
}
