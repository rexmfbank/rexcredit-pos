import 'package:equatable/equatable.dart';
import 'package:rex_api/src/endpoints/internal_transfer/internal_balance_enquiry/models/balance_enquiry_data.dart';

class InternalBalanceEnquiryResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final BalanceEnquiryData? data;

  InternalBalanceEnquiryResponse({
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
