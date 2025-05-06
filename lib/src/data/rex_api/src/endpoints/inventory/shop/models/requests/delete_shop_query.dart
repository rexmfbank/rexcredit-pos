class DeleteShopQuery {
  final String code;

  DeleteShopQuery({
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
