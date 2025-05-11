class SearchCustomerQuery {
  final String customerName;

  SearchCustomerQuery({
    required this.customerName,
  });

  Map<String, dynamic> toJson() => {
    "customerName": customerName,
  };
}
