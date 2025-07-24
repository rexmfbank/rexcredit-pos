dynamic getJsonForEOD({
  required String filePath,
  required String nowDate,
  required String nowTime,
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
              "text": "** MERCHANT COPY **",
              "align": "centre",
              "size": "normal",
              "isBold": true,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "END OF DAY TRANSACTION REPORT",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "[Merchant Business Name]",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Terminal ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "12345678"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Merchant ID",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "00045678"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Date",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": nowDate},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Time",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "07:02:05"},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "-------------------------------",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "#|Type|Amount|Time|STAN",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "-------------------------------",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "01|CARD|5,000|09:45|001235",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "02|CARD|2,500|10:15|001236",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "-------------------------------",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "SUMMARY",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "-------------------------------",
              "align": "centre",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": ""},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Total Transactions",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "10"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Successful",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "8"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Failed",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "2"},
          },
          {
            "isMultiline": false,
            "header": {
              "text": "Total Sales",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "NGN 150,000"},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "-------------------------------",
              "align": "centre",
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
            "isMultiline": false,
            "header": {
              "text": "For Support",
              "align": "left",
              "size": "normal",
              "isBold": false,
            },
            "body": {"text": "+234000111222"},
          },
          {
            "isMultiline": true,
            "header": {
              "text": "** END OF REPORT **",
              "align": "centre",
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
