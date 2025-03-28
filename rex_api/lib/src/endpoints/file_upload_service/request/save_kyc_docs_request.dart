import 'package:equatable/equatable.dart';

class SaveKycDocsRequest extends Equatable {
  final String documentName;
  final String documentFilePath;
  final String accountNo;
  final String title;
  final String documentType;

  const SaveKycDocsRequest(
      {required this.documentName,
      required this.documentFilePath,
      required this.accountNo,
      required this.title,
      required this.documentType});

  Map<String, dynamic> toJson() => {
        "documentName": documentName,
        "documentFilePath": documentFilePath,
        "accountNo": accountNo,
        "title": title,
        "documentType": documentType,
      };

  @override
  List<Object?> get props => [
        documentName,
        documentFilePath,
        accountNo,
        title,
        documentType,
      ];
}
