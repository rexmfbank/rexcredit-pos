import 'package:equatable/equatable.dart';

class UploadDocumentUtility extends Equatable {
  final String documentName;
  final String documentType;
  final String documentNumber;
  final String provider;

  const UploadDocumentUtility({
    required this.documentName,
    required this.documentType,
    required this.documentNumber,
    required this.provider,
  });

  const UploadDocumentUtility.empty()
      : documentName = '',
        documentType = '',
        documentNumber = '',
        provider = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_name'] = documentName;
    map['document_type'] = documentType;
    map['document_number'] = documentNumber;
    map['provider'] = provider;
    return map;
  }

  @override
  String toString() {
    return {
      "CLASS": "UploadDocumentUtility",
      "document_name": documentName,
      "document_type": documentType,
      "document_number": documentNumber,
      "provider": provider,
    }.toString();
  }

  @override
  List<Object?> get props => [
        documentName,
        documentType,
        documentNumber,
        provider,
      ];
}
