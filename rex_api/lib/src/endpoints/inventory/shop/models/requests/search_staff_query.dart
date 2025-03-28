class SearchStaffQuery {
  final String staffName;

  SearchStaffQuery({
    required this.staffName,
  });

  Map<String, dynamic> toJson() => {
    "staffName": staffName,
  };
}
