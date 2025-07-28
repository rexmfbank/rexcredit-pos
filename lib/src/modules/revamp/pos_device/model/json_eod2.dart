/// A single row in the “#|Type|Amount|Time|STAN” table.
class EODTransactionLine {
  final int index; // 1, 2, 3 …
  final String type; // e.g. CARD or CASH
  final String amount; // already formatted: 5,000
  final String timeHHMM; // 09:45

  const EODTransactionLine({
    required this.index,
    required this.type,
    required this.amount,
    required this.timeHHMM,
  });

  /// Converts *one* line into the exact block your printer expects.
  Map<String, dynamic> toJson() => {
    "isMultiline": false,
    "header": {
      "text": "${index.toString().padLeft(2, '0')}|$type|$amount|$timeHHMM",
      "align": "left",
      "size": "normal",
      "isBold": false,
    },
    "body": {"text": ""},
  };
}

/// Everything the receipt needs, including the list of rows.
class EODReportData {
  // ---- Required basics ----
  final String bitmapPath; // logo or header image on device
  final String date; // 2025-07-24
  final String time; // 18:40:21
  final String merchantName;
  final String terminalId;
  final String merchantId;

  // ---- Table lines ----
  final List<EODTransactionLine> lines;

  // ---- Summary figures ----
  final int totalTx;
  final int successfulTx;
  final int failedTx;
  final String totalSales; // already formatted: NGN 150,000

  const EODReportData({
    required this.bitmapPath,
    required this.date,
    required this.time,
    required this.merchantName,
    required this.terminalId,
    required this.merchantId,
    required this.lines,
    required this.totalTx,
    required this.successfulTx,
    required this.failedTx,
    required this.totalSales,
  });

  /// Top-level helper you will call from your code.
  Map<String, dynamic> toJson() {
    // Static “String” blocks that never change:
    final List<Map<String, dynamic>> headerBlocks = [
      _simpleLine("** MERCHANT COPY **", bold: true, center: true),
      _simpleLine("END OF DAY TRANSACTION REPORT", center: true),
      _simpleLine(merchantName, center: true),
      _kvLine("Terminal ID", terminalId),
      _kvLine("Merchant ID", merchantId),
      _kvLine("Date", date),
      _kvLine("Time", time),
      _divider(),
      _simpleLine("#|Type|Amount|Time"),
      _divider(),
    ];

    // Convert every transaction object into the JSON rows the printer wants.
    final List<Map<String, dynamic>> txBlocks =
        lines.map((l) => l.toJson()).toList();

    // Footer / summary
    final List<Map<String, dynamic>> footerBlocks = [
      _simpleLine("", multiline: true), // spacer
      _divider(),
      _simpleLine("SUMMARY"),
      _divider(),
      _kvLine("Total Transactions", totalTx.toString()),
      _kvLine("Successful", successfulTx.toString()),
      _kvLine("Failed", failedTx.toString()),
      _kvLine("Total Sales", totalSales),
      _divider(),
      _simpleLine("Powered by Rex MFB."),
      _kvLine("For Support", "+234000111222"),
      _simpleLine("** END OF REPORT **", center: true),
    ];

    return {
      "Receipt": [
        {
          "Bitmap": bitmapPath,
          "letterSpacing": 5,
          "String": [...headerBlocks, ...txBlocks, ...footerBlocks],
        },
      ],
    };
  }

  // ---------- tiny helpers to keep the code tidy ----------
  static Map<String, dynamic> _simpleLine(
    String text, {
    bool center = false,
    bool bold = false,
    bool multiline = true,
  }) => {
    "isMultiline": multiline,
    "header": {
      "text": text,
      "align": center ? "centre" : "left",
      "size": "normal",
      "isBold": bold,
    },
    "body": {"text": ""},
  };

  static Map<String, dynamic> _kvLine(String key, String value) => {
    "isMultiline": false,
    "header": {"text": key, "align": "left", "size": "normal", "isBold": false},
    "body": {"text": value},
  };

  static Map<String, dynamic> _divider() =>
      _simpleLine("-------------------------------", center: true);
}

/// Convenience wrapper so your old call site barely changes:
Map<String, dynamic> getJsonForEODv2(EODReportData data) => data.toJson();
