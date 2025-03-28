import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/meta_api_response.dart';
import 'package:rex_app/src/modules/shared/onboarding/get_started/models/user_data.dart';

class AccountCreatedApiResponse extends Equatable {
  final UserData data;
  final String message;
  final String status;
  final MetaApiResponse meta;
  final String token;
  final String device;
  final String tokenType;

  const AccountCreatedApiResponse({
    required this.data,
    required this.message,
    required this.status,
    required this.meta,
    required this.token,
    required this.device,
    required this.tokenType,
  });

  const AccountCreatedApiResponse.empty()
      : data = const UserData.empty(),
        message = '',
        status = '',
        meta = const MetaApiResponse.empty(),
        token = '',
        device = '',
        tokenType = '';

  factory AccountCreatedApiResponse.fromJson(Map<String, dynamic> json) {
    return AccountCreatedApiResponse(
      data: UserData.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
      meta: MetaApiResponse.fromJson(json['meta']),
      token: json['token'],
      device: json['device'],
      tokenType: json['token_type'],
    );
  }

  AccountCreatedApiResponse copyWith({
    UserData? data,
    String? message,
    String? status,
    MetaApiResponse? meta,
    String? token,
    String? device,
    String? tokenType,
  }) {
    return AccountCreatedApiResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
      meta: meta ?? this.meta,
      token: token ?? this.token,
      device: device ?? this.device,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "CompleteRegApiResponse",
      "data": data,
      "message": message,
      "status": status,
      "meta": meta,
      "token": token,
      "device": device,
      "tokenType": tokenType,
    }.toString();
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
        meta,
        token,
        device,
        tokenType,
      ];
}
