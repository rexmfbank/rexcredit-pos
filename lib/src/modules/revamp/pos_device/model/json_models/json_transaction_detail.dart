import 'package:rex_app/src/modules/revamp/pos_device/model/print_models/print_transaction_purchase.dart';

const String _dividerLine =
    "-----------------------------------------------------------";

///
dynamic jsonPrintQuickTransDetailCARD({
  required PrintTransactionPurchase print,
}) {
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
              "text": "********** MERCHANT COPY **********",
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
            "body": {"text": print.date},
          },
          {
            "isMultiline": false,
            "header": {
              "text": _dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "CARD PURCHASE",
              "align": "center",
              "size": "large",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": _dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.aid},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.stan},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.rrn},
          },
          {
            "isMultiline": false,
            "header": {
              "text": _dividerLine,
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
              "text": _dividerLine,
              "align": "center",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": print.narration,
              "align": "center",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": _dividerLine,
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
              "text": _dividerLine,
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
