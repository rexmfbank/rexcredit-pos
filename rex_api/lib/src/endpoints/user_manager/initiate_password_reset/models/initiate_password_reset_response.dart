import 'package:equatable/equatable.dart';

class InitiatePasswordResetResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? id;
  final String? refNo;

  const InitiatePasswordResetResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.id,
    required this.refNo,
  });

  const InitiatePasswordResetResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = '',
        refNo = null;

  factory InitiatePasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return InitiatePasswordResetResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      id: json['id'],
      refNo: json['refNo'],
    );
  }

  @override
  String toString() => {
        "CLASS": "InitiatePasswordResetResponse",
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
