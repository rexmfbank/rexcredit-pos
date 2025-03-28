import 'package:equatable/equatable.dart';

class UploadDocumentForm extends Equatable {
  final List<Object> document;

  const UploadDocumentForm({
    required this.document,
  });

  const UploadDocumentForm.empty() : document = const [];

  Map<String, dynamic> toJson() {
    return {"document": document};
  }

  @override
  List<Object?> get props => [document];
}
