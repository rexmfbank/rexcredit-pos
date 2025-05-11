class SearchShopRequest {
  final String searchTerm;

  SearchShopRequest({
    required this.searchTerm,
  });

  Map<String, dynamic> toJson() => {
        "searchTerm": searchTerm,
      };
}
