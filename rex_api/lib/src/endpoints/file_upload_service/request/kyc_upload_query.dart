class KycUploadQuery {
  final String entityCode;
  final String username;
  final String documentType;
  final String documentName;
  final String accountNo;
  final String documentTitle;

  KycUploadQuery({
    required this.entityCode,
    required this.username,
    required this.documentType,
    required this.documentName,
    required this.accountNo,
    required this.documentTitle,
  });

  Map<String, dynamic> toJson() => {
    "entityCode": entityCode,
    "username": username,
    "documentType": documentType,
    "documentName": documentName,
    "accountNo": accountNo,
    "documentTitle": documentTitle,
  };
}
