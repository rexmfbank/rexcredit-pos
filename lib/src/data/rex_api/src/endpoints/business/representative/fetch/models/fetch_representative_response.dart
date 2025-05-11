import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class FetchRepresentativeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final FetchRepresentativeData? data;

  FetchRepresentativeResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  FetchRepresentativeResponse.empty()
      : data = FetchRepresentativeData.empty(),
        responseCode = '',
        responseMessage = '',
        entityCode = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory FetchRepresentativeResponse.fromJson(Map<String, dynamic> json) {
    return FetchRepresentativeResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: json["data"] == null
          ? null
          : FetchRepresentativeData.fromJson(json['data']),
    );
  }
}
