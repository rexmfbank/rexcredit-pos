import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/more/models/document_type.dart';

class DocumentData extends Equatable {
  final int id;
  final String name;
  final List<DocumentType> types;
  //final DocumentUploaded uploadedDocument;

  const DocumentData({
    required this.id,
    required this.name,
    required this.types,
  });

  const DocumentData.empty()
      : id = 0,
        name = '',
        types = const [];

  factory DocumentData.fromJson(Map<String, dynamic> json) {
    return DocumentData(
      id: json['id'],
      name: json['name'],
      types: List<DocumentType>.from(
        json['types'].map((e) => DocumentType.fromJson(e)),
      ),
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "DocumentData",
      "id": id,
      "name": name,
      "types": types,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        types,
      ];
}
