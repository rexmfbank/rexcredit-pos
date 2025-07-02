import 'package:equatable/equatable.dart';

class ChangePinRequest extends Equatable {
  final String oldPin;
  final String newPin;
  final String entityCode;
  final String deviceId;

  const ChangePinRequest({
    required this.oldPin,
    required this.newPin,
    required this.entityCode,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => {
        "oldPin": oldPin,
        "newPin": newPin,
        "entityCode": entityCode,
        "deviceId": deviceId,
      };

  @override
  List<Object?> get props => [
        oldPin,
        newPin,
        entityCode,
        deviceId,
      ];
}
