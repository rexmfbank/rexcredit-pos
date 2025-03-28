import 'package:equatable/equatable.dart';

class MetaApiResponse extends Equatable {
  final bool otp;
  final bool security;
  final bool profile;

  const MetaApiResponse(
    this.otp,
    this.security,
    this.profile,
  );

  const MetaApiResponse.empty()
      : otp = false,
        security = false,
        profile = false;

  factory MetaApiResponse.fromJson(Map<String, dynamic> json) {
    return MetaApiResponse(
      json['otp'],
      json['security'],
      json['profile'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "MetaApiResponse",
      "otp": otp,
      "security": security,
      "profile": profile,
    }.toString();
  }

  @override
  List<Object?> get props => [otp, security, profile];
}
