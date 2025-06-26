import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_response.dart';

/// this function gets a [BaseAppTransactionResponse] object and
/// prints out a receipt after a card transaction has been made
dynamic getJsonForPrintingCardTransaction(
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

dynamic getJsonForTestingPrinter(String filePath) {
  return {
    "Receipt": [
      {
        "Bitmap": filePath,
        "letterSpacing": 5,
        "String": [
          {
            "isMultiline": true,
            "header": {
              "text": "RECEIPT (testing)",
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
            "body": {"text": "0192938838383833"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Ref No.",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "YEU27828383738"}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Inter Bank",
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
            "body": {"text": "Calvin James"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Sender Acct",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "1234589430"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Date-Time",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "2025-01-01 05:34:02"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AMOUNT",
              "align": "left",
              "size": "normal",
              "isBold": true
            },
            "body": {"text": "1500.00", "isBold": true}
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Successful",
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
            "body": {"text": "John Doe"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Acct",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "0012300123"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Bank",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "CIP Bank"}
          },
        ]
      },
    ]
  };
}
