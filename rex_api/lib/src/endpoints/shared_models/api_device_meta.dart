import 'package:equatable/equatable.dart';

class ApiDeviceMeta extends Equatable {
  final String os;
  final String ip;
  final String platform;
  final String deviceId;
  final String terminalId;
  final String geolocation;
  final String locationName;

  const ApiDeviceMeta({
    required this.os,
    required this.ip,
    required this.platform,
    required this.deviceId,
    required this.terminalId,
    required this.geolocation,
    required this.locationName,
  });

  factory ApiDeviceMeta.fromJson(Map<String, dynamic> json) {
    return ApiDeviceMeta(
      os: json['os'] as String,
      ip: json['ip'] as String,
      platform: json['platform'] as String,
      deviceId: json['deviceId'] as String,
      terminalId: json['terminalId'] as String,
      geolocation: json['geolocation'] as String,
      locationName: json['locationName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "os": os,
        "ip": ip,
        "platform": platform,
        "deviceId": deviceId,
        "terminalId": terminalId,
        "geolocation": geolocation,
        "locationName": locationName,
      };

  @override
  String toString() {
    return {
      "CLASS": "ApiDeviceMeta",
      "os": os,
      "ip": ip,
      "platform": platform,
      "deviceId": deviceId,
      "terminalId": terminalId,
      "geolocation": geolocation,
      "locationName": locationName,
    }.toString();
  }

  @override
  List<Object?> get props => [
        os,
        ip,
        platform,
        deviceId,
        terminalId,
        geolocation,
        locationName,
      ];
}
