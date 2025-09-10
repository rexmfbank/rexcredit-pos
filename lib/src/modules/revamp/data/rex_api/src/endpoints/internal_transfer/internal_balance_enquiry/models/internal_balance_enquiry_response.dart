import 'package:equatable/equatable.dart';
import 'balance_enquiry_data.dart';

class InternalBalanceEnquiryResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final BalanceEnquiryData? data;

  const InternalBalanceEnquiryResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  InternalBalanceEnquiryResponse.empty()
      : responseCode = '',
        responseMessage = '',
        data = BalanceEnquiryData.empty();

  factory InternalBalanceEnquiryResponse.fromJson(Map<String, dynamic> json) {
    return InternalBalanceEnquiryResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: json['data'] == null
          ? null
          : BalanceEnquiryData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [responseCode, responseMessage, data];
}
