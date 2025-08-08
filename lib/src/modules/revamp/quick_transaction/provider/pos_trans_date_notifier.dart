import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final posTransDateProvider =
    NotifierProvider<PosTransDateNotifier, PosTransDateState>(
      () => PosTransDateNotifier(),
    );

class PosTransDateNotifier extends Notifier<PosTransDateState> {
  @override
  PosTransDateState build() {
    return PosTransDateState(
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

class PosTransDateState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String startString;
  final String endString;
  final TextEditingController startController;
  final TextEditingController endController;

  const PosTransDateState({
    required this.startDate,
    required this.endDate,
    required this.startString,
    required this.endString,
    required this.startController,
    required this.endController,
  });

  PosTransDateState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? startString,
    String? endString,
    TextEditingController? startController,
    TextEditingController? endController,
  }) {
    return PosTransDateState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startString: startString ?? this.startString,
      endString: endString ?? this.endString,
      startController: startController ?? this.startController,
      endController: endController ?? this.endController,
    );
  }

  @override
  List<Object?> get props => [
    startDate,
    endDate,
    startString,
    endString,
    startController,
    endController,
  ];
}
