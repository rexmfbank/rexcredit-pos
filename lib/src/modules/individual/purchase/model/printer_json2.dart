import 'package:rex_api/rex_api.dart';

/// this function gets a [TransferData] object and
/// prints out a receipt for the transaction item shown
/// on the Transaction Detail screen
dynamic getJsonForPrintingTransactionDetail(
  TransferData data,
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
            "body": {"text": "${data.tranUniqueRefNo}"}
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
            "body": {"text": "${data.senderAccountNumber}"}
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Date-Time",
              "align": "left",
              "size": "normal",
              "isBold": false
            },
            "body": {"text": "${data.transactionDate}"}
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
              "text": "${data.transactionStatus}",
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
            "body": {"text": "${data.beneficiaryAccountNumber}"}
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
