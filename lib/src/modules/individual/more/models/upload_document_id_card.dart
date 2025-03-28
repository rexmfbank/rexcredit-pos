import 'package:equatable/equatable.dart';

class UploadDocumentIdCard extends Equatable {
  final String documentName;
  final String documentType;
  final String documentNumber;

  /// the Base64 String representation of the Id Card image
  final String document;

  const UploadDocumentIdCard({
    required this.documentName,
    required this.documentType,
    required this.documentNumber,
    required this.document,
  });

  const UploadDocumentIdCard.empty()
      : documentName = '',
        documentType = '',
        documentNumber = '',
        document = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_name'] = documentName;
    map['document_type'] = documentType;
    map['document_number'] = documentNumber;
    map['document'] = document;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "UploadDocumentUtility",
      "document_name": documentName,
      "document_type": documentType,
      "document_number": documentNumber,
      "document": document,
    }.toString();
  }

  @override
  List<Object?> get props => [
        documentName,
        documentType,
        documentNumber,
        document,
      ];
}
