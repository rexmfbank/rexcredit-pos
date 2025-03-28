import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RequestStatementState extends Equatable {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final DateTime? startDate;
  final DateTime? endDate;
  final String format;

  const RequestStatementState({
    required this.startDateController,
    required this.endDateController,
    this.startDate,
    this.endDate,
    required this.format,
  });

  RequestStatementState copyWith({
    TextEditingController? startDateController,
    TextEditingController? endDateController,
    DateTime? startDate,
    DateTime? endDate,
    String? format,
  }) {
    return RequestStatementState(
      startDateController: startDateController ?? this.startDateController,
      endDateController: endDateController ?? this.endDateController,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      format: format ?? this.format,
    );
  }

  @override
  List<Object?> get props => [
        startDateController,
        endDateController,
        startDate,
        endDate,
        format,
      ];
}
