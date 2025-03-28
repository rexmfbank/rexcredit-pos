import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/profile/get_next_of_kin/models/get_next_of_kin_data.dart';

class GetNextOfKinResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final GetNextOfKinData? data;

  GetNextOfKinResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory GetNextOfKinResponse.fromJson(Map<String, dynamic> json) {
    return GetNextOfKinResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json['data'] == null ? null : GetNextOfKinData.fromJson(json['data']),
    );
  }
}
