import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

showNotificationModalSheet({
  required BuildContext context,
  bool isDismissible = false,
  bool enableDrag = true,
  void Function()? onPressed,
  required InTransferData data,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Payment Received',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.ah),
              Text(
                "You have just received ${data.amount.formatAmountNoIntl()} from ${data.senderName}",
              ),
              SizedBox(height: 40.ah),
              Text(
                "\u20A6 ${data.amount.formatAmountNoIntl()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: RexElevatedButton(
                    onPressed: () => context.pop(),
                    buttonTitle: 'Ok',
                  ),
                ),
              ),
              SizedBox(height: 8.ah),
              // Row(
              //   children: [
              //     Expanded(
              //       child: RexElevatedButton(
              //         onPressed: () => context.pop(),
              //         buttonTitle: 'Ok',
              //       ),
              //     ),
              //     SizedBox(width: 8.aw),
              //     Expanded(
              //       child: RexElevatedButton(
              //         onPressed: () {},
              //         buttonTitle: 'Print Receipt',
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    },
  );
}

showTemporalModalSheet({
  required BuildContext context,
  bool isDismissible = false,
  bool enableDrag = true,
  void Function()? onPressed,
  required String notifBody,
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
        heightFactor: 0.40,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Payment Received',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 60.ah),
              Text(
                textAlign: TextAlign.center,
                notifBody,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              SizedBox(height: 20.ah),
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: RexElevatedButton(
                    onPressed: () => context.pop(),
                    buttonTitle: 'Ok',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
