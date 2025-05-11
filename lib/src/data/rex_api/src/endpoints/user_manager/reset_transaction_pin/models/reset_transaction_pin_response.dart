import 'package:equatable/equatable.dart';

class ResetTransactionPinResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? id;
  final Object? refNo;

  const ResetTransactionPinResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.id,
    required this.refNo,
  });

  const ResetTransactionPinResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = null,
        refNo = null;

  factory ResetTransactionPinResponse.fromJson(Map<String, dynamic> json) {
    return ResetTransactionPinResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      id: json['id'],
      refNo: json['refNo'],
    );
  }

  @override
  String toString() => {
        "CLASS": "ResetTransactionPinResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "id": id,
        "refNo": refNo,
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        id,
        refNo,
      ];
}
