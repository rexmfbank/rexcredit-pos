import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class FilterDateState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final TextEditingController startController;
  final TextEditingController endController;

  const FilterDateState({
    required this.startDate,
    required this.endDate,
    required this.startController,
    required this.endController,
  });

  FilterDateState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    TextEditingController? startController,
    TextEditingController? endController,
  }) {
    return FilterDateState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startController: startController ?? this.startController,
      endController: endController ?? this.endController,
    );
  }

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "startText": startController.text,
        "endText": endController.text,
      };

  @override
  String toString() => "FilterDateState ${toJson()}";

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        startController,
        endController,
      ];
}
