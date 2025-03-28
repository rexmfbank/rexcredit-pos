class UpdatePaymentStatusRequest {
  final String orderNumber;
  final String paymentStatus;

  UpdatePaymentStatusRequest({
    required this.orderNumber,
    required this.paymentStatus,
  });

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "paymentStatus": paymentStatus,
  };
}
