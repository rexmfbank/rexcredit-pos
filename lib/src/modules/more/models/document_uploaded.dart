import 'package:equatable/equatable.dart';

class DocumentUploaded extends Equatable {
  final int id;
  final int documentId;
  final String? imageUrl;
  final String status;
  final String createdAt;
  final String documentNumber;
  final String documentType;
  final dynamic provider;
  final dynamic subtype;
  final dynamic comment;
  final dynamic response; // initially String?

  const DocumentUploaded({
    required this.id,
    required this.documentId,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.documentNumber,
    required this.documentType,
    required this.provider,
    required this.subtype,
    required this.comment,
    required this.response,
  });

  const DocumentUploaded.empty()
      : id = 0,
        documentId = 0,
        imageUrl = null,
        status = '',
        createdAt = '',
        documentNumber = '',
        documentType = '',
        provider = '',
        subtype = '',
        comment = '',
        response = null;

  factory DocumentUploaded.fromJson(Map<String, dynamic> json) {
    return DocumentUploaded(
      id: json['id'],
      documentId: json['document_id'],
      imageUrl: json['image_url'],
      status: json['status'],
      createdAt: json['created_at'],
      documentNumber: json['document_number'],
      documentType: json['document_type'],
      provider: json['provider'],
      subtype: json['subtype'],
      comment: json['comment'],
      response: json['response'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "DocumentUploaded",
      "id": id,
      "documentId": documentId,
      "imageUrl": imageUrl,
      "status": status,
      "createdAt": createdAt,
      "documentNumber": documentNumber,
      "documentType": documentType,
      "provider": provider,
      "subtype": subtype,
      "comment": comment,
      "response": response,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        documentId,
        imageUrl,
        status,
        createdAt,
        documentNumber,
        documentType,
        provider,
        subtype,
        comment,
        response,
      ];
}
