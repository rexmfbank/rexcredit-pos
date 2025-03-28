class RexApiException implements Exception {
  RexApiException({
    this.message,
    this.responseCode,
    this.responseMessage,
  });

  RexApiException.defaultMessage({
    this.message = 'An error occurred, please try again.',
  }) : super();

  RexApiException.incompleteProcess({
    this.message = 'Sorry, we are unable to complete this process.',
  }) : super();

  String? message;
  String? responseCode;
  String? responseMessage;

  factory RexApiException.fromJson(Map<String, dynamic> json) =>
      RexApiException(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
      );

  @override
  String toString() {
    switch (message) {
      case "Invalid email":
        return "you have an invalid email";
      default:
        return message ?? '';
    }
  }
}
