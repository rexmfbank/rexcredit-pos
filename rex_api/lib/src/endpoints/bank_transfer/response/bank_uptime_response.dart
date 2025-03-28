import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/bank_transfer/response/uptime_data.dart';

class BankUptimeResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final List<UptimeData> data;

  const BankUptimeResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  const BankUptimeResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = const [];

  factory BankUptimeResponse.fromJson(Map<String, dynamic> json) {
    return BankUptimeResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: List.from(
        json['data'].map((e) => UptimeData.fromJson(e)),
      ),
    );
  }

  @override
  String toString() => {
        "CLASS": "BankUptimeResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
