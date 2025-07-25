import 'package:rex_app/src/modules/revamp/pos_device/model/json_eod2.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/utils/extensions/extension_on_double.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

mixin EodMixin {
  List<EODTransactionLine> transformToLineDataV1(
    List<PosTransactionsResponseData> transactions,
  ) {
    return transactions.asMap().entries.map((entry) {
      final idx = entry.key;
      final tx = entry.value;
      return EODTransactionLine(
        index: idx + 1,
        type: tx.tranType ?? 'n/a',
        amount: tx.amount.toCurrencyNoSymbol(),
        timeHHMM: tx.tranDate.toHm(),
        stan: "${idx}REX",
      );
    }).toList();
  }

  List<EODTransactionLine> transformToLineDataV2(
    List<PosTransactionsResponseData> transactions,
  ) {
    final result = <EODTransactionLine>[];
    for (var i = 0; i < transactions.length; i++) {
      final tx = transactions[i];
      result.add(
        EODTransactionLine(
          index: i + 1,
          amount: tx.amount.toCurrencyNoSymbol(),
          timeHHMM: tx.tranDate.toHm(),
          type: tx.tranType ?? 'n/a',
          stan: "${i}REX",
        ),
      );
    }
    return result;
  }

  num getTotalSales(List<PosTransactionsResponseData> transactions) {
    if (transactions.isEmpty) return 0;
    return transactions.map((tx) => tx.amount!).reduce((a, b) => a + b);
    //return transactions.fold<num>(0, (sum, tx) => sum + tx.amount);
  }

  int countStatus(
    List<PosTransactionsResponseData> transactions,
    String check,
  ) {
    return transactions.where((tx) => tx.status!.toLowerCase() == check).length;
  }
}
