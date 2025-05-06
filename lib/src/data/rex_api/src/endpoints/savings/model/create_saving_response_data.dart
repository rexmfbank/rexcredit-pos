import 'package:equatable/equatable.dart';

class CreateSavingResponseData extends Equatable {
  final int id;
  final String productCode;
  final String entityCode;
  final String username;
  final String sourceAccount;
  final String planName;
  final num targetAmount;
  final num maturityDate;
  final String frequency;
  final num initialAmount;
  final num recurringAmount;
  final num nextSavingDate;
  final String fundingSourceType;
  final String fundingSourceId;
  final String autoSave;
  final String status;
  final num interestRate;
  final Object? interestAccrued;
  final num totalAmount;
  final Object? witholdingTax;
  final Object? penaltyFee;
  final Object? amountPaidOut;
  final num createdDate;
  final String createdBy;
  final Object? modifiedDate;
  final Object? modifiedBy;

  const CreateSavingResponseData({
    required this.id,
    required this.productCode,
    required this.entityCode,
    required this.username,
    required this.sourceAccount,
    required this.planName,
    required this.targetAmount,
    required this.maturityDate,
    required this.frequency,
    required this.initialAmount,
    required this.recurringAmount,
    required this.nextSavingDate,
    required this.fundingSourceType,
    required this.fundingSourceId,
    required this.autoSave,
    required this.status,
    required this.interestRate,
    required this.interestAccrued,
    required this.totalAmount,
    required this.witholdingTax,
    required this.penaltyFee,
    required this.amountPaidOut,
    required this.createdDate,
    required this.createdBy,
    required this.modifiedDate,
    required this.modifiedBy,
  });

  const CreateSavingResponseData.empty()
      : id = 0,
        productCode = '',
        entityCode = '',
        username = '',
        sourceAccount = '',
        planName = '',
        targetAmount = 0,
        maturityDate = 0,
        frequency = '',
        initialAmount = 0,
        recurringAmount = 0,
        nextSavingDate = 0,
        fundingSourceType = '',
        fundingSourceId = '',
        autoSave = '',
        status = '',
        interestRate = 0,
        interestAccrued = null,
        totalAmount = 0,
        witholdingTax = null,
        penaltyFee = null,
        amountPaidOut = null,
        createdDate = 0,
        createdBy = '',
        modifiedDate = null,
        modifiedBy = null;

  factory CreateSavingResponseData.fromJson(Map<String, dynamic> json) {
    return CreateSavingResponseData(
      id: json['id'] as int,
      productCode: json['productCode'] as String,
      entityCode: json['entityCode'] as String,
      username: json['username'] as String,
      sourceAccount: json['sourceAccount'] as String,
      planName: json['planName'] as String,
      targetAmount: json['targetAmount'] as num,
      maturityDate: json['maturityDate'] as num,
      frequency: json['frequency'] as String,
      initialAmount: json['initialAmount'] as num,
      recurringAmount: json['recurringAmount'] as num,
      nextSavingDate: json['nextSavingDate'] as num,
      fundingSourceType: json['fundingSourceType'] as String,
      fundingSourceId: json['fundingSourceId'] as String,
      autoSave: json['autoSave'] as String,
      status: json['status'] as String,
      interestRate: json['interestRate'] as num,
      interestAccrued: json['interestAccrued'],
      totalAmount: json['totalAmount'] as num,
      witholdingTax: json['witholdingTax'],
      penaltyFee: json['penaltyFee'],
      amountPaidOut: json['amountPaidOut'],
      createdDate: json['createdDate'] as num,
      createdBy: json['createdBy'] as String,
      modifiedDate: json['modifiedDate'],
      modifiedBy: json['modifiedBy'],
    );
  }

  @override
  String toString() => {
        "CLASS": "SavingsResponseData",
        "id": id,
        "productCode": productCode,
        "entityCode": entityCode,
        "username": username,
        "sourceAccount": sourceAccount,
        "planName": planName,
        "targetAmount": targetAmount,
        "maturityDate": maturityDate,
        "frequency": frequency,
        "initialAmount": initialAmount,
        "recurringAmount": recurringAmount,
        "nextSavingDate": nextSavingDate,
        "fundingSourceType": fundingSourceType,
        "fundingSourceId": fundingSourceId,
        "autoSave": autoSave,
        "status": status,
        "interestRate": interestRate,
        "interestAccrued": interestAccrued,
        "totalAmount": totalAmount,
        "witholdingTax": witholdingTax,
        "penaltyFee": penaltyFee,
        "amountPaidOut": amountPaidOut,
        "createdDate": createdDate,
        "createdBy": createdBy,
        "modifiedDate": modifiedDate,
        "modifiedBy": modifiedBy
      }.toString();

  @override
  List<Object?> get props => [
        id,
        productCode,
        entityCode,
        username,
        sourceAccount,
        planName,
        targetAmount,
        maturityDate,
        frequency,
        initialAmount,
        recurringAmount,
        nextSavingDate,
        fundingSourceType,
        fundingSourceId,
        autoSave,
        status,
        interestRate,
        interestAccrued,
        totalAmount,
        witholdingTax,
        penaltyFee,
        amountPaidOut,
        createdDate,
        createdBy,
        modifiedDate,
        modifiedBy,
      ];
}
