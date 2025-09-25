import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

/// this function gets a [BaseAppTransactionResponse] object and
/// prints out a receipt after a card transaction has been made
dynamic getJsonForPrintingCardPurchase({
  required BaseAppTransactionResponse baseAppResponse,
  required String filePath,
  required String appVersionText,
  required String copyType,
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
              "text": copyType,
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
            "body": {"text": "${baseAppResponse.merchantName}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.merchantId}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Transaction Time",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.datetime}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.stan}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.rrn}"},
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
            "body": {"text": "${baseAppResponse.appLabel}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card PAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.maskedPan}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.aid}"},
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
            "body": {"text": "NGN ${baseAppResponse.amount}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Status Code",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.statuscode}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Response Message",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "${baseAppResponse.message}"},
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
