import 'package:equatable/equatable.dart';

class CustomerTierLimit extends Equatable {
  final String tranCode;
  final String tranName;
  final double maxLimit;
  final double dailyLimit;
  final double monthlyLimit;
  final int dailyFreq;

  const CustomerTierLimit({
    required this.tranCode,
    required this.tranName,
    required this.maxLimit,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.dailyFreq,
  });

  factory CustomerTierLimit.fromJson(Map<String, dynamic> json) {
    return CustomerTierLimit(
      tranCode: json['tranCode'] as String,
      tranName: json['tranName'] as String,
      maxLimit: json['maxLimit'] as double,
      dailyLimit: json['dailyLimit'] as double,
      monthlyLimit: json['monthlyLimit'] as double,
      dailyFreq: json['dailyFreq'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        "tranCode": tranCode,
        "tranName": tranName,
        "maxLimit": maxLimit,
        "dailyLimit": dailyLimit,
        "monthlyLimit": monthlyLimit,
        "dailyFreq": dailyFreq
      };

  @override
  String toString() => "CustomerTierLimit: ${toJson()}";

  @override
  List<Object?> get props => [
        tranCode,
        tranName,
        maxLimit,
        dailyLimit,
        monthlyLimit,
        dailyFreq,
      ];
}
