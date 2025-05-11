class LookupDataQuery {
  final String categoryCode;
  final String entityCode;
  final int? pageNumber;
  final int? pageSize;

  LookupDataQuery({
    required this.categoryCode,
    required this.entityCode,
    this.pageNumber,
    this.pageSize,
  });

  Map<String, dynamic> toJson() => {
        "categoryCode": categoryCode,
        "entityCode": entityCode,
        "pageNumber": pageNumber ?? 1,
        "pageSize": pageSize ?? 15,
      };
}
