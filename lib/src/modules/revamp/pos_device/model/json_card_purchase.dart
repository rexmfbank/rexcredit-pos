import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

/// this function gets a [BaseAppTransactionResponse] object and
/// prints out a receipt after a card transaction has been made
dynamic getJsonForPrintingCardPurchase(
  BaseAppTransactionResponse response,
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
            "body": {"text": "${response.merchantName}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.merchantId}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Transaction Time",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.datetime}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.stan}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.rrn}"},
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
            "isMultiline": false,
            "header": {
              "text": "CARD INFO",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card Type",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.appLabel}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card PAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.maskedPan}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.aid}"},
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
              "text": "TRANSANCTION SUMMARY",
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
            "body": {"text": "${response.amount}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Status",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.statuscode}"},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Message",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${response.message}"},
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
              "text": "Need help? Call 08077554422",
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
              "text": "Powered by Rex MFB",
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
