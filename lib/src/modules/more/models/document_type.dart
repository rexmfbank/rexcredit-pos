import 'package:equatable/equatable.dart';

class DocumentType extends Equatable {
  final int id;
  final int documentId;
  final String name;
  final bool status;
  final String createdAt;

  const DocumentType({
    required this.id,
    required this.documentId,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  const DocumentType.empty()
      : id = 0,
        documentId = 0,
        name = '',
        status = false,
        createdAt = '';

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json['id'],
      documentId: json['document_id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  DocumentType copyWith({
    int? id,
    int? documentId,
    String? name,
    bool? status,
    String? createdAt,
  }) {
    return DocumentType(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "DocumentType",
      "id": id,
      "documentId": documentId,
      "name": name,
      "status": status,
      "createdAt": createdAt,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        documentId,
        name,
        status,
        createdAt,
      ];
}
