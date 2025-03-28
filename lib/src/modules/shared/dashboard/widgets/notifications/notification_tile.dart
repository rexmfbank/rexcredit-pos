import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/notification_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

class NotificationTile extends ConsumerWidget {
  final NotificationInfo info;
  final VoidCallback? onTap;
  const NotificationTile({
    super.key,
    required this.info,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.ah),
      child: Opacity(
        opacity: info.status == 'Y' ? 0.4 : 1.0,
        child: AbsorbPointer(
          absorbing: info.status == 'Y',
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap?.call();
                return;
              }

              ref.watch(notificationProvider.notifier).updateNotificationStatus(
                    context: context,
                    notificationId: info.id ?? 0,
                  );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.ah, horizontal: 14.aw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.ar),
                color: AppColors.rexWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fiber_manual_record_sharp,
                            size: 20.ar,
                            color: AppColors.rexPurpleLight,
                          ),
                          SizedBox(width: 5.aw),
                          Text(
                            info.subject ?? StringAssets.notification,
                            style: AppTextStyles.body1Regular.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        info.createdDate?.dateTimeReadable() ?? '',
                        style: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.ah),
                  Text(
                    info.content ?? '',
                    style: AppTextStyles.body1Regular,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
