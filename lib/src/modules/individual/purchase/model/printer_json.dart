import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_response.dart';

dynamic getJsonForPrintingCardTransaction(
  BaseAppTransactionResponse response,
) {
  return {
    "Receipt": [
      {
        "Bitmap": "filename",
        "letterSpacing": 5,
        "String": [
          {
            "isMultiline": true,
            "header": {
              "text": "***RECEIPT***",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.merchantName}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.merchantId}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Terminal ID",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.terminalId}"}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "CARD TRANSACTION",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "STAN",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.stan}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "RRN",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.rrn}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AID",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.aid}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "DATE-TIME",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.datetime}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AMOUNT",
              "align": "left",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": "${response.amount}", "isBold": true}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "${response.message}",
              "align": "centre",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": ""}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Status code",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.statuscode}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card Exp Date",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.cardExpireDate}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card Name",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.cardHolderName}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.maskedPan}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Card type",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${response.appLabel}"}
          },
        ]
      },
    ]
  };
}
