import 'package:equatable/equatable.dart';

class UserDocument extends Equatable {
  final int id;
  final int userId;
  final int documentId;
  final String? imageUrl;
  final String status;
  final String createdAt;
  final String? documentNumber;
  final String documentType;
  final Object? provider;
  final Object? subtype;
  final Object? comment;
  final Object? response;

  const UserDocument({
    required this.id,
    required this.userId,
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

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      id: json['id'],
      userId: json['user_id'],
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
      'id': id,
      'user_id': userId,
      'document_id': documentId,
      'image_url': imageUrl,
      'status': status,
      'created_at': createdAt,
      'document_number': documentNumber,
      'document_type': documentType,
      'provider': provider,
      'subtype': subtype,
      'comment': comment,
      'response': response,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
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
