class UpdateNotificationRequest {
  final int notificationId;

  UpdateNotificationRequest({
    required this.notificationId,
  });

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
  };
}
