import 'package:rex_app/src/modules/revamp/pos_device/model/print_card_purchase.dart';
import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

const String dividerLine =
    "-----------------------------------------------------------";

/// this function gets a [BaseAppTransactionResponse] object and
/// prints out a receipt after a card transaction has been made
dynamic jsonPrintCardPurchaseV2({required PrintCardPurchase print}) {
  return {
    "Receipt": [
      {
        "Bitmap": print.filePath,
        "letterSpacing": 7,
        "String": [
          {
            "isMultiline": false,
            "header": {
              "text": " ",
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "********** ${print.copyType} **********",
              "align": "center",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": " ",
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": print.merchantName,
              "align": "center",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": " ",
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.merchantId},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Terminal ID",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.terminalId},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "DATE-TIME",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.datetime},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "PURCHASE",
              "align": "center",
              "size": "large",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "CARD TYPE",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.appLabel},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "CARD PAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.maskedPan},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.aid},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.stan},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.rrn},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AMOUNT",
              "align": "center",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": "NGN ${print.amount}"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": print.message,
              "align": "center",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": print.appVersionText,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Need help? Call 07049054042",
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "or email: contact@rexmfbank.com",
              "align": "center",
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
