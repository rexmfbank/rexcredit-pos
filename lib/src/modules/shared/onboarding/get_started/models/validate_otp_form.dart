import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';

class ValidateOtpForm extends Equatable {
  /// username is an email address, not just a random string.
  final String username;
  final String otpToken;
  final DeviceMetaData? meta;

  const ValidateOtpForm({
    required this.username,
    required this.otpToken,
    required this.meta,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['token'] = otpToken;
    map['meta'] = meta?.toJson();
    return map;
  }

  ValidateOtpForm copyWith({
    String? username,
    String? otpToken,
    DeviceMetaData? meta,
  }) {
    return ValidateOtpForm(
      username: username ?? this.username,
      otpToken: otpToken ?? this.otpToken,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "ValidateOtpForm",
      "username": username,
      "otpToken": otpToken,
      "meta": meta,
    }.toString();
  }

  @override
  List<Object?> get props => [
        username,
        otpToken,
        meta,
      ];
}
