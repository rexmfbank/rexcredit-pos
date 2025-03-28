import 'package:equatable/equatable.dart';

class ApiMetaData extends Equatable {
  final bool profile;
  final bool security;
  final bool emailVerified;
  final bool phoneVerified;

  const ApiMetaData({
    required this.profile,
    required this.security,
    required this.emailVerified,
    required this.phoneVerified,
  });

  const ApiMetaData.empty()
      : profile = false,
        security = false,
        emailVerified = false,
        phoneVerified = false;

  factory ApiMetaData.fromJson(Map<String, dynamic> json) {
    return ApiMetaData(
      profile: json['profile'] as bool,
      security: json['security'] as bool,
      emailVerified: json['email_verified'] as bool,
      phoneVerified: json['phone_verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "security": security,
        "email_verified": emailVerified,
        "phone_verified": phoneVerified,
      };

  @override
  String toString() {
    return {
      "CLASS": "ApiMetaData",
      "profile": profile,
      "security": security,
      "email_verified": emailVerified,
      "phone_verified": phoneVerified,
    }.toString();
  }

  @override
  List<Object?> get props => [
        profile,
        security,
        emailVerified,
        phoneVerified,
      ];
}
