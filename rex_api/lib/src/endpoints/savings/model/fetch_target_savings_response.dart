import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/savings/model/fetch_target_savings_data.dart';

class FetchTargetSavingsResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final List<FetchTargetSavingsData>? data;

  const FetchTargetSavingsResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.entityCode,
    required this.data,
  });

  const FetchTargetSavingsResponse.empty()
      : responseCode = '',
        responseMessage = '',
        entityCode = null,
        data = const [];

  factory FetchTargetSavingsResponse.fromJson(Map<String, dynamic> json) {
    return FetchTargetSavingsResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      entityCode: json['entityCode'],
      data: json['data'] == null
          ? null
          : List.from(
              json['data'].map((e) => FetchTargetSavingsData.fromJson(e)),
            ),
    );
  }

  @override
  String toString() => {
        "CLASS": "FetchTargetSavingsResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}
