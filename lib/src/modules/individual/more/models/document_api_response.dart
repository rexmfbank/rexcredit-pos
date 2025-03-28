import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/individual/more/models/document_data.dart';

class DocumentApiResponse extends Equatable {
  final List<DocumentData> data;
  final String message;
  final String status;

  const DocumentApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  const DocumentApiResponse.empty()
      : data = const [],
        message = '',
        status = '';

  factory DocumentApiResponse.fromJson(Map<String, dynamic> json) {
    return DocumentApiResponse(
      data: List<DocumentData>.from(
        json['data'].map((e) => DocumentData.fromJson(e)),
      ),
      message: json['message'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "DcoumentApiResponse",
      "data": data,
      "message": message,
      "status": status,
    }.toString();
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
      ];
}
