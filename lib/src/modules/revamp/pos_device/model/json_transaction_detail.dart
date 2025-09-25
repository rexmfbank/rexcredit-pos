import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

///
dynamic getJsonForPrintingTransDetailCARD({
  required PosTransactionsResponseData transData,
  required String filePath,
  required String appVersionText,
  required String merchantId,
  required String merchantName,
}) {
  return {
    "Receipt": [
      {
        "Bitmap": filePath,
        "letterSpacing": 5,
        "String": [
          {
            "isMultiline": true,
            "header": {
              "text": "REX MICROFINANCE BANK",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RECEIPT",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "MERCHANT COPY",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "--------------------",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant Name",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": merchantName},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": merchantId},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Transaction Time",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.tranDate}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.stan}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.rrn}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.aid}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Transaction Type",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "PURCHASE"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "--------------------",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "TRANSACTION SUMMARY",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Amount",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "NGN ${transData.amount}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Status",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.status}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Message",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${transData.narration}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "--------------------",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Thank you for using Rex POS",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Need help? Call 07049054042",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "or email: contact@rexmfbank.com",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Powered by Rex MFB.",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": appVersionText,
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
        ],
      },
    ],
  };
}
