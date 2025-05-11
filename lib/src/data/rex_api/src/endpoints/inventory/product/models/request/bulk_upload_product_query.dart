
class BulkProductUploadQuery{
  final String storeCode;

  const BulkProductUploadQuery({
    required this.storeCode,
});

  Map<String, dynamic> toJson() => {
    "storeCode": storeCode,
  };
}