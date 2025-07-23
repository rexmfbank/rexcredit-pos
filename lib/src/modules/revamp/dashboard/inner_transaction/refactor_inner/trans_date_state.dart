import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TransactionDateState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String startString;
  final String endString;
  final TextEditingController startController;
  final TextEditingController endController;

  const TransactionDateState({
    required this.startDate,
    required this.endDate,
    required this.startString,
    required this.endString,
    required this.startController,
    required this.endController,
  });

  TransactionDateState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? startString,
    String? endString,
    TextEditingController? startController,
    TextEditingController? endController,
  }) {
    return TransactionDateState(
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
