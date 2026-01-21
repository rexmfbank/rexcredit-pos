import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

showNotificationModalSheetV2({
  required BuildContext context,
  bool isDismissible = true,
  bool enableDrag = true,
  void Function()? onPressed,
  required PosNotification data,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isDismissible: isDismissible,
    isScrollControlled: true,
    enableDrag: enableDrag,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.50,
        child: Consumer(
          builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Payment Info Received',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.ah),
                  Text(
                    "\u20A6 ${data.amount.formatAmountNoIntl()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: RexElevatedButton(
                        onPressed: () {
                          ref
                              .read(posCardPurchaseProvider.notifier)
                              .setNotificationData(data: data);
                          context.push(Routes.selectPayScreen);
                        },
                        buttonTitle: 'Pay Fee',
                      ),
                    ),
                  ),
                  SizedBox(height: 8.ah),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class NotificationModalWidget extends StatelessWidget {
  const NotificationModalWidget({super.key, required this.data});

  final PosNotification data;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.60,
      child: Consumer(
        builder: (context, ref, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Payment Info Received',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40.ah),
                Text(
                  "\u20A6 ${data.amount.formatAmountNoIntl()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: RexElevatedButton(
                      onPressed: () {
                        // ref
                        //     .read(posNotifCardPurchaseProvider.notifier)
                        //     .initDataForNotifPurchase(
                        //       data: data,
                        //       context: context,
                        //     );
                      },
                      buttonTitle: 'Pay with Card',
                    ),
                  ),
                ),
                SizedBox(height: 8.ah),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: RexElevatedButton(
                      onPressed: () => context.push(Routes.nfcReaderScreen),
                      buttonTitle: 'Pay with NFC',
                    ),
                  ),
                ),
                SizedBox(height: 8.ah),
              ],
            ),
          );
        },
      ),
    );
  }
}
