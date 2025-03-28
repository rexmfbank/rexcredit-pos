class GetNotificationsResponse {
  final String responseCode;
  final String responseMessage;
  final List<NotificationInfo> data;
  final int pageIndex;
  final int pageSize;
  final int totalPages;
  final int totalCount;

  GetNotificationsResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
    required this.pageIndex,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
  });

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) => GetNotificationsResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    data: List<NotificationInfo>.from(json["data"].map((x) => NotificationInfo.fromJson(x))),
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
    totalPages: json["totalPages"],
    totalCount: json["totalCount"],
  );
}

class NotificationInfo {
  final int? id;
  final String? subject;
  final String? content;
  final String? status;
  final DateTime? createdDate;

  NotificationInfo({
     this.id,
     this.subject,
     this.content,
     this.status,
     this.createdDate,
  });

  factory NotificationInfo.fromJson(Map<String, dynamic> json) => NotificationInfo(
    id: json["id"],
    subject: json["subject"],
    content: json["content"],
    status: json["status"],
    createdDate: DateTime.tryParse(json["createdDate"] ?? ''),
  );
}
