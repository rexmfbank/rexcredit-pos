import 'package:equatable/equatable.dart';

class SelfPasswordResetResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? id;
  final Object? refNo;

  const SelfPasswordResetResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.id,
    required this.refNo,
  });

  const SelfPasswordResetResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = null,
        refNo = null;

  factory SelfPasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return SelfPasswordResetResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      id: json['id'],
      refNo: json['refNo'],
    );
  }

  @override
  String toString() => {
        "CLASS": "SelfPasswordResetResponse",
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
