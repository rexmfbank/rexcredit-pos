import 'package:equatable/equatable.dart';

class VerifyNewDeviceRequest extends Equatable {
  final String username;
  final String mobileNumber;
  final String otp;
  final String entityCode;
  final String deviceId;
  final String actionCode;

  const VerifyNewDeviceRequest({
    required this.username,
    required this.mobileNumber,
    required this.otp,
    required this.entityCode,
    required this.deviceId,
    required this.actionCode,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "mobileNo": mobileNumber,
        "otp": otp,
        "entityCode": entityCode,
        "deviceId": deviceId,
        "actionCode": actionCode
      };

  @override
  List<Object?> get props => [
        username,
        mobileNumber,
        otp,
        entityCode,
        deviceId,
        actionCode,
      ];
}
