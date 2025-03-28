import 'package:equatable/equatable.dart';

class UploadDocumentFormApiResponse extends Equatable {
  final String status;
  final String message;
  final List data;

  const UploadDocumentFormApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  const UploadDocumentFormApiResponse.empty()
      : status = '',
        message = '',
        data = const [];

  factory UploadDocumentFormApiResponse.fromJson(Map<String, dynamic> json) {
    return UploadDocumentFormApiResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "UploadDocumentApiResponse",
      "status": status,
      "message": message,
      "data": data,
    }.toString();
  }

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
