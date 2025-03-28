import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class CreateRepresentativeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final CreateRepresentativeData? data;

  CreateRepresentativeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    this.data,
  });

  CreateRepresentativeResponse.empty()
      : data = CreateRepresentativeData.empty(),
        responseCode = '',
        responseMessage = '',
        entityCode = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory CreateRepresentativeResponse.fromJson(Map<String, dynamic> json) {
    return CreateRepresentativeResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json['data'] == null ? null : CreateRepresentativeData.fromJson(json['data']),
    );
  }
}
