import 'package:equatable/equatable.dart';

class CreateSavingRequest extends Equatable {
  final String maturityDate;
  final String planName;
  final num targetAmount;
  final String frequency;
  final String currency;
  final String autoSave;
  final String fundingSource;
  final String fundingSourceId;
  final num amount;
  final num recurringAmount;
  final String autoStartDate;
  final String geoLocation;
  final String externalRefNo;

  const CreateSavingRequest({
    required this.maturityDate,
    required this.planName,
    required this.targetAmount,
    required this.frequency,
    required this.currency,
    required this.autoSave,
    required this.fundingSource,
    required this.fundingSourceId,
    required this.amount,
    required this.recurringAmount,
    required this.autoStartDate,
    required this.geoLocation,
    required this.externalRefNo,
  });

  Map<String, dynamic> toJson() => {
        "maturityDate": maturityDate,
        "planName": planName,
        "targetAmount": targetAmount,
        "frequency": frequency,
        "currency": currency,
        "auto_save": autoSave,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "amount": amount,
        "recurringAmount": recurringAmount,
        "autoStartDate": autoStartDate,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo
      };

  @override
  String toString() => {
        "maturityDate": maturityDate,
        "planName": planName,
        "targetAmount": targetAmount,
        "frequency": frequency,
        "currency": currency,
        "auto_save": autoSave,
        "fundingSource": fundingSource,
        "fundingSourceId": fundingSourceId,
        "amount": amount,
        "recurringAmount": recurringAmount,
        "autoStartDate": autoStartDate,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo
      }.toString();

  @override
  List<Object?> get props => [
        maturityDate,
        planName,
        targetAmount,
        frequency,
        currency,
        autoSave,
        fundingSource,
        fundingSourceId,
        amount,
        recurringAmount,
        autoStartDate,
        geoLocation,
        externalRefNo
      ];
}
