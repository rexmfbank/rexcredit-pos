import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';

class GetStartedNumberForm extends Equatable {
  final String phoneNumber;
  final DeviceMetaData? meta;

  const GetStartedNumberForm({
    required this.phoneNumber,
    required this.meta,
  });

  factory GetStartedNumberForm.fromJson(Map<String, dynamic> json) {
    return GetStartedNumberForm(
      phoneNumber: json['phone_number'],
      meta: DeviceMetaData.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = phoneNumber;
    map['meta'] = meta?.toJson();
    return map;
  }

  GetStartedNumberForm copyWith({
    String? phoneNumber,
    String? errorMessage,
    DeviceMetaData? meta,
  }) {
    return GetStartedNumberForm(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "GetStartedNumberForm",
      "email": phoneNumber,
      "meta": meta,
    }.toString();
  }

  @override
  List<Object?> get props => [phoneNumber, meta];
}
