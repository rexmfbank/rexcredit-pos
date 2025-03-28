class EncryptRequestTemplate {
  final String data;

  EncryptRequestTemplate({
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}