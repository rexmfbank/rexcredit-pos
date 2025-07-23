import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/revamp/quick_transaction/transactions/refactor/trans_date_state.dart';

final transactionDateProvider =
    NotifierProvider<TransactionDateNotifier, TransactionDateState>(
      () => TransactionDateNotifier(),
    );

class TransactionDateNotifier extends Notifier<TransactionDateState> {
  @override
  TransactionDateState build() {
    return TransactionDateState(
      startController: TextEditingController(),
      endController: TextEditingController(),
      startDate: null,
      endDate: null,
      startString: '',
      endString: '',
    );
  }

  void onStartDateChange(DateTime? value) {
    if (value != null) {
      state = state.copyWith(
        startDate: value,
        startString: DateFormat.yMMMd().format(value),
      );
    }
  }

  void onEndDateChange(DateTime? value) {
    if (value != null) {
      state = state.copyWith(
        endDate: value,
        endString: DateFormat.yMMMd().format(value),
      );
    }
  }

  void setDatesToNull() {
    log("DATE IS NULL: ");
    state = state.copyWith(
      startDate: null,
      endDate: null,
      startString: '',
      endString: '',
      startController: TextEditingController(),
      endController: TextEditingController(),
    );
  }
}
