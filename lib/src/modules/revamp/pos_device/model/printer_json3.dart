import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

dynamic getJsonForPrintingQuickTransactionDetail(
  PosTransactionsResponseData data,
  String filePath,
) {
  return {
    "Receipt": [
      {
        "Bitmap": filePath,
        "letterSpacing": 5,
        "String": [
          {
            "isMultiline": true,
            "header": {
              "text": "RECEIPT (transaction)",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Session ID",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.sessionId}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Ref No.",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.tranUniqRefNo}"}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "${data.tranType}",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Sender",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.senderName}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Sender Acct",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.sourceAccount}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Date-Time",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.tranDate}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AMOUNT",
              "align": "left",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": "${data.amount}", "isBold": true}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "${data.status}",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.beneficiaryName}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Acct",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.beneficiaryAccountNo}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Bank",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.beneficiaryBank}"}
          },
        ]
      },
    ]
  };
}
