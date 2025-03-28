class GetAllEmployeesQuery {
  final int pageNumber;
  final int pageSize;
  final String businessCode;
  final String? name;
  final String? email;
  final String? department;

  GetAllEmployeesQuery({
    required this.pageNumber,
    required this.pageSize,
    required this.businessCode,
    this.name,
    this.email,
    this.department,
  });

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "businessCode": businessCode,
        "name": name,
        "email": email,
        "department": department,
      };
}
