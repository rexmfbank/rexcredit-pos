class GetKycDocsQuery {
  final String username;
  final String entityCode;
  final String category;

  GetKycDocsQuery({
    required this.username,
    required this.entityCode,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "entityCode": entityCode,
    "category": category,
  };
}
