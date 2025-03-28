import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String channelType;
  final String username;
  final String password;
  final String refreshToken;
  final String language;
  final String deviceId;

  const LoginRequest({
    required this.channelType,
    required this.username,
    required this.password,
    required this.refreshToken,
    required this.language,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => {
        "channelType": channelType,
        "username": username,
        "password": password,
        "refreshToken": refreshToken,
        "language": language,
        "deviceId": deviceId
      };

  @override
  String toString() => {
        "CLASS": "LoginRequest",
        "channelType": channelType,
        "username": username,
        "password": password,
        "refreshToken": refreshToken,
        "language": language,
        "deviceId": deviceId
      }.toString();

  @override
  List<Object?> get props => [
        channelType,
        username,
        password,
        refreshToken,
        language,
        deviceId,
      ];
}
