import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

PosTransactionsResponseData modelNotiftoUIModel(InTransferData transferData) {
  return PosTransactionsResponseData(
    tranCode: transferData.tranCode,
    tranType: transferData.tranType,
    tranUniqRefNo: "${transferData.tranUniqRefNo}",
    tranRefNo: '',
    tranDesc: transferData.narration,
    amount: double.parse(transferData.amount),
    responseCode: '',
    responseMessage: '',
    cbaReferenceNo: '',
    paymentRspCode: '',
    paymentRspMsg: '',
    paymentRefNo: '',
    currencyCode: '',
    narration: transferData.narration,
    beneficiaryBank: transferData.beneficiaryBank,
    beneficiaryAccountNo: transferData.beneficiaryAccountNo,
    sourceAccount: '',
    tranDate: transferData.tranDate,
    beneficiaryBankCode: '',
    beneficiaryName: transferData.beneficiaryName,
    token: '',
    sessionId: transferData.sessionId,
    status: transferData.status,
    senderName: transferData.senderName,
    paymentStatus: transferData.status,
    aid: '',
    crDr: '',
    merchantName: '',
    rrn: '',
    stan: '',
    terminalId: '',
    merchantId: '',
    senderAccountNumber: transferData.senderAccountNumber,
  );
}

String bodyOfPushNotif(InTransferData data) {
  const check = '\u2705';
  const naira = '\u20A6';
  return "$naira ${data.amount.formatAmountNoIntl()} received from ${data.senderName}. Ref No:${data.tranUniqRefNo}. Transaction approved $check";
}
