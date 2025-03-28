import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/meta_api_response.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_data.dart';

class AuthenticatedUserApiResponse extends Equatable {
  final UserData data;
  final String message;
  final String status;
  final MetaApiResponse meta;
  final String? token;
  final String? tokenType;
  final String? device;

  const AuthenticatedUserApiResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.meta,
    this.token,
    this.tokenType,
    this.device,
  });

  const AuthenticatedUserApiResponse.empty()
      : data = const UserData.empty(),
        message = '',
        status = '',
        meta = const MetaApiResponse.empty(),
        token = null,
        tokenType = null,
        device = null;

  factory AuthenticatedUserApiResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUserApiResponse(
      data: UserData.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
      meta: MetaApiResponse.fromJson(json['meta']),
      token: json['token'],
      tokenType: json['device'],
      device: json['token_type'],
    );
  }

  AuthenticatedUserApiResponse copyWith({
    UserData? data,
    String? message,
    String? status,
    MetaApiResponse? meta,
    String? token,
    String? tokenType,
    String? device,
  }) {
    return AuthenticatedUserApiResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
      meta: meta ?? this.meta,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      device: device ?? this.device,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "AuthenticatedUserApiResponse",
      "data": data,
      "message": message,
      "status": status,
      "meta": meta,
      "token": token,
      "tokenType": tokenType,
      "device": device,
    }.toString();
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
        meta,
        token,
        tokenType,
        device,
      ];
}
