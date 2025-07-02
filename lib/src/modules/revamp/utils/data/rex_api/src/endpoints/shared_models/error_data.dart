import 'package:equatable/equatable.dart';

class ErrorData extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? id;
  final String? refNo;

  const ErrorData({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    this.refNo,
  });

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
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

class ErrorDto {
  final String? flag;
  final String? securityQuestion;

  ErrorDto({
    this.flag,
    this.securityQuestion,
  });

  factory ErrorDto.fromJson(Map<String, dynamic> json) => ErrorDto(
    flag: json["flag"],
    securityQuestion: json["securityQuestion"],
  );
}
