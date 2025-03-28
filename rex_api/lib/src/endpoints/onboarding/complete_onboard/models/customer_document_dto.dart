import 'package:equatable/equatable.dart';

class CustomerDocumentDto extends Equatable {
  final String documentType;
  final String documentName;
  final String documentPath;
  final String documentRefNo;
  final String documentTitle;

  const CustomerDocumentDto({
    required this.documentType,
    required this.documentName,
    required this.documentPath,
    required this.documentRefNo,
    required this.documentTitle,
  });

  Map<String, dynamic> toJson() => {
        "documentType": documentType,
        "documentName": documentName,
        "documentPath": documentPath,
        "documentRefNo": documentRefNo,
        "documentTitle": documentTitle
      };

  @override
  List<Object?> get props => [
        documentType,
        documentName,
        documentPath,
        documentRefNo,
        documentTitle,
      ];
}
