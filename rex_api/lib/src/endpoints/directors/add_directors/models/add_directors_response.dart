import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class AddDirectorsResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final AddDirectorsResponseData? data;

  AddDirectorsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  AddDirectorsResponse.empty()
      : data = AddDirectorsResponseData.empty(),
        responseCode = '',
        responseMessage = '',
        entityCode = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory AddDirectorsResponse.fromJson(Map<String, dynamic> json) {
    return AddDirectorsResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json['data'] != null ? AddDirectorsResponseData.fromJson(json['data']) : AddDirectorsResponseData.empty(),
      
    );
  }
}
