/// A single row in the “#|Type|Amount|Time|STAN” table.
class EODTransactionLine {
  final int index; // 1, 2, 3 …
  final String type; // e.g. CARD or CASH
  final String amount; // already formatted: 5,000
  final String timeHHMM; // 09:45
  final String transStatus;
  final String tranType; // credt, debit

  const EODTransactionLine({
    required this.index,
    required this.type,
    required this.amount,
    required this.timeHHMM,
    required this.transStatus,
    required this.tranType,
  });

  EODTransactionLine.empty()
    : index = 0,
      type = '',
      amount = '',
      timeHHMM = '',
      transStatus = '',
      tranType = '';

  /// Converts *one* line into the exact block your printer expects.
  Map<String, dynamic> toJson() {
    final amt = retAmt(amount, transStatus);
    return {
      "isMultiline": false,
      "header": {
        "text":
            "${index.toString().padLeft(2, '0')} | $type | $amt | $timeHHMM | $transStatus",
        "align": "left",
        "size": "normal",
        "isBold": false,
      },
      "body": {"text": ""},
    };
  }

  String retAmt(String amount, String transStatus) {
    if (transStatus.toLowerCase() == 'failed') {
      return amount;
    }
    return tranType.toLowerCase() == 'credit' ? '+$amount' : '-$amount';
  }
}

/// Everything the receipt needs, including the list of rows.
class EODReportData {
  // ---- Required basics ----
  final String bitmapPath; // logo or header image on device
  final String date; // 2025-07-24
  final String time; // 18:40:21
  final String merchantName;
  final String eodDate;
  final String terminalId;
  final String merchantId;

  // ---- Table lines ----
  final List<EODTransactionLine> lines;

  // ---- Summary figures ----
  final int totalTx;
  final int successfulTx;
  final int failedTx;
  final int totalPurchase;
  final int sucessPurchase;
  final int failPurchase;
  final int totalTransfer;
  final int sucessTransfer;
  final int failTransfer;
  final String totalSales; // already formatted: NGN 150,000
  final String appVersion;

  const EODReportData({
    required this.bitmapPath,
    required this.date,
    required this.time,
    required this.merchantName,
    required this.eodDate,
    required this.terminalId,
    required this.merchantId,
    required this.lines,
    required this.totalTx,
    required this.successfulTx,
    required this.failedTx,
    required this.totalPurchase,
    required this.sucessPurchase,
    required this.failPurchase,
    required this.totalTransfer,
    required this.sucessTransfer,
    required this.failTransfer,
    required this.totalSales,
    required this.appVersion,
  });

  /// Top-level helper you will call from your code.
  Map<String, dynamic> toJson() {
    // Static “String” blocks that never change:
    final List<Map<String, dynamic>> headerBlocks = [
      _simpleLine("** MERCHANT COPY **", bold: true, center: true),
      _simpleLine("END OF DAY TRANSACTION REPORT", center: true),
      _simpleLine("FOR DAY: ", center: true),
      _simpleLine(eodDate, center: true),
      _simpleLine(merchantName, center: true, multiline: true),
      _kvLine("Terminal ID", terminalId),
      _kvLine("Merchant ID", merchantId),
      _kvLine("Date Printed", date),
      _kvLine("Time Printed", time),
      _divider(),
      _simpleLine("#| Type | Amount | Time | Status"),
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
      _simpleLine("TRANSACTIONS"),
      _kvLine("Total", totalTx.toString()),
      _kvLine("Successful", successfulTx.toString()),
      _kvLine("Failed", failedTx.toString()),
      _divider(),
      _simpleLine("PURCHASES"),
      _kvLine("Total", totalPurchase.toString()),
      _kvLine("Successful", sucessPurchase.toString()),
      _kvLine("Failed", failPurchase.toString()),
      _divider(),
      _simpleLine("TRANSFERS"),
      _kvLine("Total", totalTransfer.toString()),
      _kvLine("Successful", sucessTransfer.toString()),
      _kvLine("Failed", failTransfer.toString()),
      _divider(),
      _simpleLine("Total Sales"),
      _simpleLine(totalSales),
      _divider(),
      _simpleLine("Powered by Rex MFB."),
      _simpleLine(appVersion),
      _kvLine("For Support", "07049054042"),
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
    bool multiline = false,
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
      _simpleLine("****************************************", center: true);
}

/// Convenience wrapper so your old call site barely changes:
Map<String, dynamic> getJsonForEODv2(EODReportData data) => data.toJson();
