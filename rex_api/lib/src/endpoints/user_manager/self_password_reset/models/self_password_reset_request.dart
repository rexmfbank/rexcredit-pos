import 'package:equatable/equatable.dart';

class SelfPasswordResetRequest extends Equatable {
  final String otp;
  final String mobileNumber;
  final String username;
  final String entityCode;
  final String newPassword;

  const SelfPasswordResetRequest({
    required this.otp,
    required this.mobileNumber,
    required this.username,
    required this.entityCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "mobileNo": mobileNumber,
        "username": username,
        "entityCode": entityCode,
        "newPwd": newPassword
      };

  @override
  String toString() => {
        "CLASS": "SelfPasswordResetRequest",
        "otp": otp,
        "mobileNo": mobileNumber,
        "username": username,
        "entityCode": entityCode,
        "newPwd": newPassword
      }.toString();

  @override
  List<Object?> get props => [
        otp,
        mobileNumber,
        username,
        entityCode,
        newPassword,
      ];
}
