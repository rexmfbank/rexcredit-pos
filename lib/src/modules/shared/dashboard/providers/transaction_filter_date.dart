import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/dashboard/models/filter_date_state.dart';

// final transactionFilterDateProvider =
//     AutoDisposeNotifierProvider<TransactionFilterDate, FilterDateState>(
//   () => TransactionFilterDate(),
// );

class TransactionFilterDate extends AutoDisposeNotifier<FilterDateState> {
  @override
  FilterDateState build() {
    return FilterDateState(
      startController: TextEditingController(),
      endController: TextEditingController(),
      startDate: null,
      endDate: null,
    );
  }

  void onStartDateChange(DateTime? value) {
    if (value == null) return;
    state = state.copyWith(startDate: value);
  }

  void onEndDateChange(DateTime? value) {
    if (value == null) return;
    state = state.copyWith(endDate: value);
  }

  void setDatesToNull() {
    state = state.copyWith(startDate: null, endDate: null);
  }
}
