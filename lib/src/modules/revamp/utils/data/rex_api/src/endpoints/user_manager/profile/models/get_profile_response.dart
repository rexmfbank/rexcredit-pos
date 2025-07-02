import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class GetProfileResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final GetProfileResponseData? data;

  GetProfileResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  GetProfileResponse.empty()
      : data = GetProfileResponseData.empty(),
        responseCode = '',
        responseMessage = '';

  @override
  List<Object?> get props => [responseCode, responseMessage, data];

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'] == null
          ? null
          : GetProfileResponseData.fromJson(json['data']),
    );
  }
}
