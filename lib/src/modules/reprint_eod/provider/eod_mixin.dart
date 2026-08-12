import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/pos_device/model/json_models/json_eod.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

final _currencyFmt = NumberFormat.currency(symbol: '', decimalDigits: 2);
num _toMinorUnits(num? amount) => amount ?? 0;

mixin EodMixin {
  List<EODTransactionLine> transformToLineDataFast(
    List<PosTransactionsResponseData> transactions,
  ) {
    final result = <EODTransactionLine>[];
    var index = 0;
    for (var i = 0; i < transactions.length; i++) {
      final tx = transactions[i];
      final n = tx.narration?.toLowerCase();
      if (n != null && n.startsWith('fee')) continue;
      index++;
      result.add(
        EODTransactionLine(
          index: index,
          type: tx.posType ?? 'n/a',
          amount: _currencyFmt.format(_toMinorUnits(tx.amount)),
          timeHHMM: tx.tranDate?.toHm() ?? '',
          transStatus: tx.status ?? '',
        ),
      );
    }
    return result;
  }

  // num getTotalSales(List<PosTransactionsResponseData> txs) => double.parse(
  //   txs
  //       .fold<num>(0, (sum, tx) {
  //         final s = tx.status?.toLowerCase();
  //         if (s != 'successful') return sum;
  //         final n = tx.narration?.toLowerCase();
  //         if (n != null && n.startsWith('fee')) return sum;
  //         final p = tx.posType?.toLowerCase();
  //         if (p == 'transfer' || p == 'card') {
  //           return sum + _toMinorUnits(tx.amount);
  //         }
  //         return sum;
  //       })
  //       .toStringAsFixed(2),
  // );

  String getTotalSales(List<PosTransactionsResponseData> txs) =>
      _currencyFmt.format(
        txs.fold<num>(0, (sum, tx) {
          final s = tx.status?.toLowerCase();
          if (s != 'successful') return sum;
          final n = tx.narration?.toLowerCase();
          if (n != null && n.startsWith('fee')) return sum;
          final p = tx.posType?.toLowerCase();
          if (p == 'transfer' || p == 'card') {
            return sum + _toMinorUnits(tx.amount);
          }
          return sum;
        }),
      );

  // int countStatus(List<PosTransactionsResponseData> txs, String check) {
  //   final checkLc = check.toLowerCase();
  //   return txs.where((tx) => tx.status?.toLowerCase() == checkLc).length;
  // }

  // int countStatus(List<PosTransactionsResponseData> txs, String check) {
  //   final checkLc = check.toLowerCase();
  //   return txs.where((tx) {
  //     final n = tx.narration?.toLowerCase();
  //     if (n != null && n.startsWith('fee')) return false;
  //     return tx.status?.toLowerCase() == checkLc;
  //   }).length;
  // }

  // int countStatusPurchase(List<PosTransactionsResponseData> txs, String check) {
  //   final checkLc = check.toLowerCase();
  //   return txs.where((tx) {
  //     final n = tx.narration?.toLowerCase();
  //     if (n != null && n.startsWith('fee')) return false;
  //     return tx.status?.toLowerCase() == checkLc && tx.posType == 'card';
  //   }).length;
  // }

  // int countStatusTransfer(List<PosTransactionsResponseData> txs, String check) {
  //   final checkLc = check.toLowerCase();
  //   return txs.where((tx) {
  //     final n = tx.narration?.toLowerCase();
  //     if (n != null && n.startsWith('fee')) return false;
  //     return tx.status?.toLowerCase() == checkLc && tx.posType == 'transfer';
  //   }).length;
  // }

  int countType(
    List<PosTransactionsResponseData> txs,
    String status, {
    String? type,
  }) {
    final statusLc = status.toLowerCase();
    final posTypeLc = type?.toLowerCase();
    return txs.where((tx) {
      final n = tx.narration?.toLowerCase();
      if (n != null && n.startsWith('fee')) return false;
      if (tx.status?.toLowerCase() != statusLc) return false;
      if (posTypeLc != null && tx.posType?.toLowerCase() != posTypeLc) {
        return false;
      }
      return true;
    }).length;
  }
}
