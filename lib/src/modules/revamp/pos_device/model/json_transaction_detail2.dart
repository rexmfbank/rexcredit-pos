import 'package:rex_app/src/modules/revamp/pos_device/model/print_transaction_transfer.dart';

const String _dividerLine =
    "-----------------------------------------------------------";

///
dynamic jsonPrintQuickTransDetailNOCARD({
  required PrintTransactionTransfer print,
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
            "body": {"text": print.tranDate},
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
              "text": "TRANSFER",
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
              "text": "REF NO.",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.tranUniqRefNo},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "BENEFICIARY",
              "align": "left",
              "size": "large",
              "isBold": false,
            },
            "body": {"text": print.beneficiaryName},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "BENEFICIARY BANK",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.beneficiaryBank},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "BENEFICIARY ACCT.",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.beneficiaryAccountNo},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "SENDER",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.senderName},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "SENDER ACCT.",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": print.senderAccountNumber},
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
