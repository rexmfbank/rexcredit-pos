import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class NotificationModel {
  final bool isLoading;
  final bool append;
  final int pageIndex;
  final GetNotificationsResponse? notificationResponse;
  final ScrollController scrollController;
  final List<NotificationInfo> notifications;

  const NotificationModel({
    required this.scrollController,
    this.isLoading = false,
    this.append = false,
    this.pageIndex = 1,
    this.notificationResponse,
    this.notifications = const [],
  });

  NotificationModel copyWith({
    bool? isLoading,
    bool? append,
    int? pageIndex,
    ScrollController? scrollController,
    GetNotificationsResponse? notificationResponse,
    List<NotificationInfo>? notifications,
  }) {
    return NotificationModel(
      isLoading: isLoading ?? this.isLoading,
      append: append ?? this.append,
      pageIndex: pageIndex ?? this.pageIndex,
      scrollController: scrollController ?? this.scrollController,
      notificationResponse: notificationResponse ?? this.notificationResponse,
      notifications: notifications ?? this.notifications,
    );
  }
}
