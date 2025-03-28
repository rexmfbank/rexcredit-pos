class SearchProductRequest {
  String searchTerm;

  SearchProductRequest({
    required this.searchTerm,
  });

  SearchProductRequest copyWith({
    String? searchTerm,
  }) =>
      SearchProductRequest(
        searchTerm: searchTerm ?? this.searchTerm,
      );

  Map<String, dynamic> toJson() => {
    "searchTerm": searchTerm,
  };
}
