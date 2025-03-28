import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';

class GetStartedEmailForm extends Equatable {
  final String email;
  final DeviceMetaData? meta;

  const GetStartedEmailForm({
    required this.email,
    required this.meta,
  });

  factory GetStartedEmailForm.fromJson(Map<String, dynamic> json) {
    return GetStartedEmailForm(
      email: json['email'],
      meta: DeviceMetaData.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['meta'] = meta?.toJson();
    return map;
  }

  GetStartedEmailForm copyWith({
    String? email,
    String? errorMessage,
    DeviceMetaData? meta,
  }) {
    return GetStartedEmailForm(
      email: email ?? this.email,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "GetStartedEmailForm",
      "email": email,
      "meta": meta,
    }.toString();
  }

  @override
  List<Object?> get props => [email, meta];
}
