import 'package:equatable/equatable.dart';
import 'customer_tier_limit.dart';

class CustomerTierResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String customerType;
  final List<CustomerTierLimit>? data;

  const CustomerTierResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.customerType,
    this.data,
  });

  factory CustomerTierResponse.fromJson(Map<String, dynamic> json) {
    return CustomerTierResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      customerType: json['customerType'] as String,
      data: json['data'] == null
          ? null
          : List.from(json['data'].map((e) => CustomerTierLimit.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() => {
        "customerType": customerType,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data,
      };

  @override
  String toString() => "CustomerTierResponse ${toJson()}";

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        customerType,
        data,
      ];
}
