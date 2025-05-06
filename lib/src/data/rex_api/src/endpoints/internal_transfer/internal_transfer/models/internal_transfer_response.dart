import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class InternalTransferResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final TransferData? data;

  const InternalTransferResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  InternalTransferResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = TransferData();

  factory InternalTransferResponse.fromJson(Map<String, dynamic> json) {
    return InternalTransferResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json["data"] == null ? null : TransferData.fromJson(json["data"]),
    );
  }

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
