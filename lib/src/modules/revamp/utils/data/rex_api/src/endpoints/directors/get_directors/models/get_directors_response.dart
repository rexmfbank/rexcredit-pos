import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class GetDirectorsResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final List<GetDirectorsResponseData> data;

  GetDirectorsResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  GetDirectorsResponse.empty()
      : data = [],
        responseCode = '',
        responseMessage = '',
        entityCode = null;

  @override
  List<Object?> get props => [responseCode, responseMessage, entityCode, data];

  factory GetDirectorsResponse.fromJson(Map<String, dynamic> json) {
    return GetDirectorsResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'] as String?,
      data: (json['data'] as List)
            .map((item) => GetDirectorsResponseData.fromJson(item))
            .toList(),
    );
  }
}
