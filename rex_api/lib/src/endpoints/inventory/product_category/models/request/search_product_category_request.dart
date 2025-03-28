import 'dart:convert';

class SearchProductCategoryRequest {
  String searchTerm;

  SearchProductCategoryRequest({
    required this.searchTerm,
  });

  SearchProductCategoryRequest copyWith({
    String? searchTerm,
  }) =>
      SearchProductCategoryRequest(
        searchTerm: searchTerm ?? this.searchTerm,
      );

  factory SearchProductCategoryRequest.fromRawJson(String str) => SearchProductCategoryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchProductCategoryRequest.fromJson(Map<String, dynamic> json) => SearchProductCategoryRequest(
    searchTerm: json["searchTerm"],
  );

  Map<String, dynamic> toJson() => {
    "searchTerm": searchTerm,
  };
}
