import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/dashboard/models/notification_model.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

final notificationProvider =
    NotifierProvider<NotificationNotifier, NotificationModel>(
  () => NotificationNotifier(),
);

class NotificationNotifier extends Notifier<NotificationModel> {
  @override
  NotificationModel build() => NotificationModel(
        scrollController: ScrollController(),
      );

  void appendNotifications(BuildContext context) {
    if (state.pageIndex < (state.notificationResponse?.totalPages ?? 0)) {
      if (state.scrollController.offset >=
              state.scrollController.position.maxScrollExtent &&
          !state.scrollController.position.outOfRange) {
        state = state.copyWith(
          pageIndex: state.pageIndex + 1,
          append: true,
        );
        getNotifications(context: context);
      }
    }
  }

  Future<void> refreshCall(BuildContext context) async {
    state = state.copyWith(pageIndex: 1, append: false);
    getNotifications(context: context);
  }

  Future<void> getNotifications({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    try {
      final apiResponse = await RexApi.instance.getNotificationHistory(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        query: GetNotificationsQuery(
          pageNumber: state.pageIndex,
          pageSize: AppConstants.pageSize,
          username: ref.read(usernameProvider),
        ),
      );
      state = state.copyWith(
        isLoading: false,
        notifications: state.append
            ? (state.notifications.toList()..addAll(apiResponse.data))
            : apiResponse.data,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: e.toString(),
        );
      }
    }
  }

  Future<void> updateNotificationStatus({
    required BuildContext context,
    required int notificationId,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      await RexApi.instance.updateNotificationStatus(
        authToken: ref.read(userAuthTokenProvider) ?? '',
        request: UpdateNotificationRequest(notificationId: notificationId),
      );
      state = state.copyWith(
        isLoading: false,
      );
      if (context.mounted) {
        getNotifications(context: context);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: e.toString(),
        );
      }
    }
  }

  Future<void> deleteNotifications({required BuildContext context}) async {
    state = state.copyWith(isLoading: true, append: false);
    try {
      await RexApi.instance.deleteNotifications(
        authToken: ref.read(userAuthTokenProvider) ?? '',
      );
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        getNotifications(context: context);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: e.toString(),
        );
      }
    }
  }
}
