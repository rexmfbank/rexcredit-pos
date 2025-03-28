import 'package:equatable/equatable.dart';

class SavingsReturnRequest extends Equatable {
  final String maturityDate;
  final num targetAmount;
  final String autoSave;
  final String frequency;
  final String currency;
  final num recurringAmount;

  const SavingsReturnRequest({
    required this.maturityDate,
    required this.targetAmount,
    required this.autoSave,
    required this.frequency,
    required this.currency,
    required this.recurringAmount,
  });

  Map<String, dynamic> toJson() => {
        "maturityDate": maturityDate,
        "targetAmount": targetAmount,
        "autoSave": autoSave,
        "frequency": frequency,
        "currency": currency,
        "recurringAmount": recurringAmount,
      };

  @override
  String toString() => {
        "CLASS": "SavingsReturnRequest",
        "maturityDate": maturityDate,
        "targetAmount": targetAmount,
        "autoSave": autoSave,
        "frequency": frequency,
        "currency": currency,
        "recurringAmount": recurringAmount,
      }.toString();

  @override
  List<Object?> get props => [
        maturityDate,
        targetAmount,
        autoSave,
        frequency,
        currency,
        recurringAmount,
      ];
}
