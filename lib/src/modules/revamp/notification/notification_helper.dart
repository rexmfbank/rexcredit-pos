import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

String bodyOfPushNotifV2(PosNotification data) {
  const check = '\u2705';
  const naira = '\u20A6';
  return "$naira ${data.amount.formatAmountNoIntl()}";
}


String bodyOfPushNotif(InTransferData data) {
  const check = '\u2705';
  const naira = '\u20A6';
  return "$naira ${data.amount.formatAmountNoIntl()} received from ${data.senderName}. Ref No:${data.tranUniqRefNo}. Transaction approved $check";
}