import 'package:equatable/equatable.dart';

class ForceUpdateResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final ForceUpdateInfo? data;

  const ForceUpdateResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const ForceUpdateResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory ForceUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ForceUpdateResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : ForceUpdateInfo.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}

class ForceUpdateInfo extends Equatable {
  final bool? forceUpdate;

  const ForceUpdateInfo({
    this.forceUpdate,
  });

  const ForceUpdateInfo.empty() : forceUpdate = false;

  factory ForceUpdateInfo.fromJson(Map<String, dynamic> json) =>
      ForceUpdateInfo(
        forceUpdate: json["forceUpdate"],
      );

  @override
  List<Object?> get props => [forceUpdate];
}
