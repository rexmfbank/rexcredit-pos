class GetNotificationsQuery {
  final int pageNumber;
  final int pageSize;
  final String username;

  GetNotificationsQuery({
    required this.pageNumber,
    required this.pageSize,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "username": username,
  };
}
