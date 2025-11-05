/*
Hide Sender Name and Sender Acct for Card Purchase on POS. 
Show this instead

Transaction Ref No:
Transaction Status: 
Transaction Date:
Amount:
Description:

Beneficiary Name: merchantName
Beneficiary Acct: we have this info

AID: aid 
PAN: maskedPan

RRN: rrn 
STAN: stan
TerminalID: terminalID
Merchant ID: merchantId
*/
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
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Session ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "0192938838383833"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Ref No.",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "YEU27828383738"},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Inter Bank",
              "align": "centre",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Sender",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "Calvin James"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Sender Acct",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "1234589430"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Date-Time",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "2025-01-01 05:34:02"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "AMOUNT",
              "align": "left",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": "1500.00", "isBold": true},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "Successful",
              "align": "centre",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "John Doe"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Acct",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "0012300123"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Beneficiary Bank",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "CIP Bank"},
          },
        ],
      },
    ],
  };
}
