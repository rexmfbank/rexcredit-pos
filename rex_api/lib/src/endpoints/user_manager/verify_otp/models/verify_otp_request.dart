import 'package:equatable/equatable.dart';

class VerifyOtpRequest extends Equatable {
  final String username;
  final String mobileNumber;
  final String otp;
  final String entityCode;
  final String deviceId;

  const VerifyOtpRequest({
    required this.username,
    required this.mobileNumber,
    required this.otp,
    required this.entityCode,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "mobileNo": mobileNumber,
        "otp": otp,
        "entityCode": entityCode,
        "deviceId": deviceId,
      };

  @override
  String toString() => {
        "CLASS": "VerifyOtpRequest",
        "username": username,
        "mobileNo": mobileNumber,
        "otp": otp,
        "entityCode": entityCode,
        "deviceId": deviceId,
      }.toString();

  @override
  List<Object?> get props => [
        username,
        mobileNumber,
        otp,
        entityCode,
        deviceId,
      ];
}
