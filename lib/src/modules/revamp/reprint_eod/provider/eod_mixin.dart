import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/revamp/pos_device/model/json_eod2.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final _currencyFmt = NumberFormat.currency(symbol: '', decimalDigits: 2);
num _toMinorUnits(num? amount) => amount ?? 0;

mixin EodMixin {
  // List<EODTransactionLine> transformToLineDataV1(
  //   List<PosTransactionsResponseData> transactions,
  // ) {
  //   return transactions.asMap().entries.map((entry) {
  //     final idx = entry.key;
  //     final tx = entry.value;
  //     return EODTransactionLine(
  //       index: idx + 1,
  //       type: tx.tranType ?? 'n/a',
  //       amount: tx.amount.toCurrencyNoSymbol(),
  //       timeHHMM: tx.tranDate.toHm(),
  //     );
  //   }).toList();
  // }

  // List<EODTransactionLine> transformToLineDataV2(
  //   List<PosTransactionsResponseData> transactions,
  // ) {
  //   final result = <EODTransactionLine>[];
  //   for (var i = 0; i < transactions.length; i++) {
  //     final tx = transactions[i];
  //     result.add(
  //       EODTransactionLine(
  //         index: i + 1,
  //         amount: tx.amount.toCurrencyNoSymbol(),
  //         timeHHMM: tx.tranDate.toHm(),
  //         type: tx.tranType ?? 'n/a',
  //       ),
  //     );
  //   }
  //   return result;
  // }

  List<EODTransactionLine> transformToLineDataFast(
    List<PosTransactionsResponseData> transactions,
  ) {
    final result = List<EODTransactionLine>.filled(
      transactions.length,
      EODTransactionLine.empty(),
      growable: false,
    );
    for (var i = 0; i < transactions.length; i++) {
      final tx = transactions[i];
      result[i] = EODTransactionLine(
        index: i + 1,
        type: tx.tranType ?? 'n/a',
        amount: _currencyFmt.format(_toMinorUnits(tx.amount)),
        timeHHMM: tx.tranDate?.toHm() ?? '',
      );
    }
    return result;
  }

  // num getTotalSales(List<PosTransactionsResponseData> transactions) {
  //   if (transactions.isEmpty) return 0;
  //   return transactions.map((tx) => tx.amount!).reduce((a, b) => a + b);
  //   //return transactions.fold<num>(0, (sum, tx) => sum + tx.amount);
  // }

  // int countStatus(
  //   List<PosTransactionsResponseData> transactions,
  //   String check,
  // ) {
  //   return transactions.where((tx) => tx.status!.toLowerCase() == check).length;
  // }

  num getTotalSales(List<PosTransactionsResponseData> txs) =>
      txs.fold<num>(0, (sum, tx) => sum + _toMinorUnits(tx.amount));

  int countStatus(List<PosTransactionsResponseData> txs, String check) {
    final checkLc = check.toLowerCase();
    return txs.where((tx) => tx.paymentStatus?.toLowerCase() == checkLc).length;
  }
}

class PrepareParams {
  /// Full list of raw POS transactions you want to crunch.
  final List<PosTransactionsResponseData> txs;

  /// The date string you show as “EOD Date” on the receipt
  /// (I’m just passing the already-formatted string instead of an
  /// entire `ReprintState` so the object stays isolate-friendly).
  final String eodDate;

  final String dateString;
  final String timeString;
  final String bitmapPath;
  final String merchantName;
  final String merchantId;
  final String terminalId;

  const PrepareParams({
    required this.txs,
    required this.eodDate,
    required this.dateString,
    required this.timeString,
    required this.bitmapPath,
    required this.merchantName,
    required this.merchantId,
    required this.terminalId,
  });
}

/// ---------------------------------------------------------------------------
/// Data you get **back** from `compute()`
/// ---------------------------------------------------------------------------
class PrepareResult {
  /// Formatted line items ready for the printer JSON
  final List<EODTransactionLine> lines;

  /// Sum of all successful transaction amounts
  final num totalSales;

  /// How many transactions have status == 'successful'
  final int okCount;

  /// How many transactions have status == 'failed'
  final int failCount;

  /// The final payload (already produced by `getJsonForEODv2`)
  ///
  /// Choose `Map<String, dynamic>` *or* `String` depending on what
  /// `startIntentPrinterAndGetResult` expects.
  /// In the snippet I showed earlier it’s a `Map` that you later
  /// `jsonEncode`, so I’m keeping it as `Map` here:
  final Map<String, dynamic> jsonPayload;

  const PrepareResult({
    required this.lines,
    required this.totalSales,
    required this.okCount,
    required this.failCount,
    required this.jsonPayload,
  });
}
