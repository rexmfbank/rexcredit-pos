class DepositDuration {
  final String responseCode;
  final String responseMessage;
  final List<String>? data;

  const DepositDuration({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  const DepositDuration.empty()
      : responseCode = '',
        responseMessage = '',
        data = null;

  factory DepositDuration.fromJson(Map<String, dynamic> json) =>
      DepositDuration(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null
            ? null
            : List<String>.from(
                json["data"].map((item) => item),
              ),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null ? [] : data!.map((x) => x).toList(),
      };

  @override
  String toString() => {
        "CLASS": "DepositDuration",
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data == null ? [] : data!.map((x) => x).toList(),
      }.toString();
}
