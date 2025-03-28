import 'package:equatable/equatable.dart';

class SavingsReturnResponseData extends Equatable {
  final num targetAmount;
  final String maturityDate;
  final String noOfTimeToSave;
  final String recurringAmountToSave;
  final String duration;
  final String frequency;
  final num interestToEarn;
  final num wht;
  final num interestAfterTax;
  final num rate;
  final String autoSave;
  final Object? planName;
  final Object? autoStartDate;
  final Object? autoStartInDays;
  final String totalAmountExpected;

  const SavingsReturnResponseData({
    required this.targetAmount,
    required this.maturityDate,
    required this.noOfTimeToSave,
    required this.recurringAmountToSave,
    required this.duration,
    required this.frequency,
    required this.interestToEarn,
    required this.wht,
    required this.interestAfterTax,
    required this.rate,
    required this.autoSave,
    required this.planName,
    required this.autoStartDate,
    required this.autoStartInDays,
    required this.totalAmountExpected,
  });

  const SavingsReturnResponseData.empty()
      : targetAmount = 0,
        maturityDate = '',
        noOfTimeToSave = '',
        recurringAmountToSave = '',
        duration = '',
        frequency = '',
        interestToEarn = 0,
        wht = 0,
        interestAfterTax = 0,
        rate = 0,
        autoSave = '',
        planName = null,
        autoStartDate = null,
        autoStartInDays = null,
        totalAmountExpected = '';

  factory SavingsReturnResponseData.fromJson(Map<String, dynamic> json) {
    return SavingsReturnResponseData(
      targetAmount: json['targetAmount'] as num,
      maturityDate: json['maturityDate'] as String,
      noOfTimeToSave: json['noOfTimeToSave'] as String,
      recurringAmountToSave: json['recurringAmountToSave'] as String,
      duration: json['duration'] as String,
      frequency: json['frequency'] as String,
      interestToEarn: json['interestToEarn'] as num,
      wht: json['wht'] as num,
      interestAfterTax: json['interestAfterTax'] as num,
      rate: json['rate'] as num,
      autoSave: json['autoSave'] as String,
      planName: json['planName'],
      autoStartDate: json['autoStartDate'],
      autoStartInDays: json['autoStartInDays'],
      totalAmountExpected: json['totalAmountExpected'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsReturnResponseData",
        "targetAmount": targetAmount,
        "maturityDate": maturityDate,
        "noOfTimeToSave": noOfTimeToSave,
        "recurringAmountToSave": recurringAmountToSave,
        "duration": duration,
        "frequency": frequency,
        "interestToEarn": interestToEarn,
        "wht": wht,
        "interestAfterTax": interestAfterTax,
        "rate": rate,
        "autoSave": autoSave,
        "planName": planName,
        "autoStartDate": autoStartDate,
        "autoStartInDays": autoStartInDays,
        "totalAmountExpected": totalAmountExpected
      }.toString();

  @override
  List<Object?> get props => [
        targetAmount,
        maturityDate,
        noOfTimeToSave,
        recurringAmountToSave,
        duration,
        frequency,
        interestToEarn,
        wht,
        interestAfterTax,
        rate,
        autoSave,
        planName,
        autoStartDate,
        autoStartInDays,
        totalAmountExpected,
      ];
}
