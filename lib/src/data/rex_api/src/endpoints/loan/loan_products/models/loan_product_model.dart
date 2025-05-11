import 'package:equatable/equatable.dart';

class LoanProductModel extends Equatable {
  final String productName;
  final String title;
  final String? description;
  final int? minTenor;
  final int? maxTenor;
  final String? tenorPeriod;
  final String productCode;
  final double? interestRate;
  final double? minPrincipalAmount;
  final double? maxPrincipalAmount;
  final double? bankStatementAmountRequired;
  final int? moratorium;

  LoanProductModel(
      {required this.productName,
      required this.title,
      required this.description,
      required this.minTenor,
      required this.maxTenor,
      required this.tenorPeriod,
      required this.productCode,
      required this.interestRate,
      required this.minPrincipalAmount,
      required this.maxPrincipalAmount,
      required this.bankStatementAmountRequired,
      required this.moratorium});

  const LoanProductModel.empty()
      : productName = '',
        title = '',
        productCode = '',
        description = '',
        minTenor = 0,
        maxTenor = 1,
        tenorPeriod = '',
        minPrincipalAmount = 0.0,
        maxPrincipalAmount = 0.0,
        bankStatementAmountRequired = 0.0,
        interestRate = 0,
        moratorium = null;

  factory LoanProductModel.fromJson(Map<String, dynamic> json) =>
      LoanProductModel(
          productName: json["productName"],
          title: json["title"],
          description: json["description"],
          minTenor: json["minTenor"],
          maxTenor: json["maxTenor"],
          tenorPeriod: json['tenorPeriod'],
          interestRate: json['interestRate'],
          productCode: json['productCode'],
          minPrincipalAmount: json['minPrincipalAmount'],
          maxPrincipalAmount: json['maxPrincipalAmount'],
          bankStatementAmountRequired: json['bankStatementAmountRequired'],
          moratorium: json['moratorium']);

  @override
  List<Object?> get props => [
        productName,
        title,
        productCode,
        description,
        minTenor,
        maxTenor,
        tenorPeriod,
        minPrincipalAmount,
        maxPrincipalAmount,
        bankStatementAmountRequired,
        interestRate,
        moratorium
      ];
}
