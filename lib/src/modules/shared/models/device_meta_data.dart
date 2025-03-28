import 'package:equatable/equatable.dart';

class DeviceMetaData extends Equatable {
  final String operatingSystem;
  final String ipAddress;
  final String platform;
  final String deviceNumber;

  const DeviceMetaData({
    required this.operatingSystem,
    required this.ipAddress,
    required this.platform,
    required this.deviceNumber,
  });

  factory DeviceMetaData.empty() {
    return const DeviceMetaData(
      operatingSystem: 'null',
      ipAddress: 'null',
      platform: 'null',
      deviceNumber: 'null',
    );
  }

  factory DeviceMetaData.fromJson(Map<String, dynamic> json) {
    return DeviceMetaData(
      operatingSystem: json['os'],
      ipAddress: json['ip'],
      platform: json['platform'],
      deviceNumber: json['device'],
    );
  }

  @override
  List<Object?> get props {
    return [
      operatingSystem,
      ipAddress,
      platform,
      deviceNumber,
    ];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['os'] = operatingSystem;
    map['ip'] = ipAddress;
    map['platform'] = platform;
    map['device'] = deviceNumber;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "DeviceMetaData",
      "os": operatingSystem,
      "ip": ipAddress,
      "platform": platform,
      "device": deviceNumber,
    }.toString();
  }
}
