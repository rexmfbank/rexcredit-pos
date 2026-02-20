// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_models/json_transaction_detail2.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_transaction_transfer.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/revamp/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/app_preference_provider.dart';
import 'package:rex_app/src/modules/revamp/utils/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

showModalPosNotification({
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
                          context.pop();
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

showModalInTransfer({
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
      return Consumer(
        builder: (context, ref, child) {
          return FractionallySizedBox(
            heightFactor: 0.70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Payment Received',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40.ah),
                  Text(
                    "You have just received ${data.amount.formatAmountNoIntl()} from ${data.senderName}",
                    textAlign: TextAlign.center,
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
                        onPressed: () => context.pop(),
                        buttonTitle: 'Okay',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: RexElevatedButton(
                        onPressed: () async {
                          printReceipt(data, context, ref);
                        },
                        buttonTitle: 'Print Receipt',
                      ),
                    ),
                  ),
                  SizedBox(height: 8.ah),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void printReceipt(
  InTransferData data,
  BuildContext context,
  WidgetRef ref,
) async {
  final baseApp = ref.watch(baseAppNameProvider);
  final appVersion = ref.read(appVersionProvider);
  final printLogo = ref.watch(printingImageProvider) ?? '';
  final merchantId = await AppSecureStorage().getPosMerchantId() ?? '';
  final merchantName = await AppSecureStorage().getPosNubanName() ?? '';
  final terminalId = await AppSecureStorage().getBaasTerminalId() ?? '';
  final filePath = baseApp == PosPackage.topwise ? topwiseFile : printLogo;
  //
  switch (baseApp) {
    case PosPackage.nexgo:
    case PosPackage.nexgorex:
    case PosPackage.telpo:
    case PosPackage.topwise:
      final dataJson = jsonPrintQuickTransDetailNOCARD(
        print: PrintTransactionTransfer(
          filePath: filePath,
          appVersionText: "Version $appVersion",
          merchantId: merchantId,
          merchantName: merchantName,
          terminalId: terminalId,
          tranDate: data.tranDate,
          amount: data.amount.formatAmount(),
          tranUniqRefNo: data.tranUniqRefNo,
          status: data.status,
          beneficiaryName: '',
          beneficiaryAccountNo: data.beneficiaryAccountNo,
          beneficiaryBank: data.beneficiaryBank,
          senderName: data.senderName,
          senderAccountNumber: data.senderAccountNumber,
        ),
      );
      await startIntentPrinterAndGetResult(
        packageName: "com.globalaccelerex.printer",
        dataKey: "extraData",
        dataValue: jsonEncode(dataJson),
      );
      break;
    case PosPackage.horizon:
      context.showToast(message: 'Printing not available');
      break;
    case PosPackage.none:
      context.showToast(message: "Cannot identify device");
      break;
  }
}
