import 'package:equatable/equatable.dart';

class DeactivateResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final Object? id;
  final Object? refNo;

  const DeactivateResponse({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    this.refNo,
  });

  const DeactivateResponse.empty()
      : responseCode = '',
        responseMessage = '',
        id = null,
        refNo = null;

  factory DeactivateResponse.fromJson(Map<String, dynamic> json) =>
      DeactivateResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        id: json["id"],
        refNo: json["refNo"],
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "id": id,
        "refNo": refNo,
      };

  @override
  String toString() => {
        "CLASS": "DeactivateResponse",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "id": id,
        "refNo": refNo,
      }.toString();

  @override
  List<Object?> get props => [responseCode, responseMessage, id, refNo];
}
