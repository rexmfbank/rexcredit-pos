class LookupListQuery {
  final String lookupCode;

  LookupListQuery({
    required this.lookupCode,
  });

  Map<String, dynamic> toJson() => {
    "lookupCode": lookupCode,
  };
}
