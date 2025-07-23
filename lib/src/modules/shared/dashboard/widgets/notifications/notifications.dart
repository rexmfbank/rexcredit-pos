import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/empty_beneficiary_list.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/notification_provider.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/notifications/notification_tile.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(notificationProvider.notifier).refreshCall(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(notificationProvider).isLoading,
      padding: EdgeInsets.symmetric(horizontal: 12.aw),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        shouldHaveBackButton: true,
        showNotification: false,
        title: StringAssets.notifications,
        subtitle: StringAssets.notificationSubtitle,
        suffixWidget: InkWell(
          onTap: () => ref
              .watch(notificationProvider.notifier)
              .deleteNotifications(context: context),
          child: Text(
            StringAssets.clearAll,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.red,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.ah, bottom: 25.ah),
        child: Builder(builder: (context) {
          if (ref.watch(notificationProvider).notifications.isEmpty) {
            return EmptyBeneficiaryList(
              loadingText: ref.watch(notificationProvider).isLoading
                  ? StringAssets.checking
                  : null,
              text: ref.watch(notificationProvider).isLoading
                  ? StringAssets.hiChecking
                  : StringAssets.notificationListEmpty,
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollState) {
              if (scrollState is ScrollEndNotification) {
                ref
                    .watch(notificationProvider.notifier)
                    .appendNotifications(context);
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.watch(notificationProvider.notifier).refreshCall(context),
              child: ListView.builder(
                controller: ref.watch(notificationProvider).scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: ref.watch(notificationProvider).notifications.length,
                itemBuilder: (context, index) => NotificationTile(
                  info: ref
                      .watch(notificationProvider)
                      .notifications
                      .elementAt(index),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
