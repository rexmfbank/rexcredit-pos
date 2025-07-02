import 'package:equatable/equatable.dart';

class ChangePinErrorData extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? id;
  final String? refNo;

  const ChangePinErrorData({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    this.refNo,
  });

  factory ChangePinErrorData.fromJson(Map<String, dynamic> json) {
    return ChangePinErrorData(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      id: json['id'] as String?,
      refNo: json['refNo'] as String?
    );
  }

  @override
  String toString() => {
        "CLASS": "ErrorData",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "id": id,
        "refNo": refNo
      }.toString();

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        id,
        refNo
      ];
}
