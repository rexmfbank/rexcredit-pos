class UpdatePaymentStatusResponse {
  final String createdDate;
  final String orderNumber;
  final String paymentStatus;

  UpdatePaymentStatusResponse({
    required this.createdDate,
    required this.orderNumber,
    required this.paymentStatus,
  });

  factory UpdatePaymentStatusResponse.fromJson(Map<String, dynamic> json) => UpdatePaymentStatusResponse(
    createdDate: json["createdDate"],
    orderNumber: json["orderNumber"],
    paymentStatus: json["paymentStatus"],
  );
}
