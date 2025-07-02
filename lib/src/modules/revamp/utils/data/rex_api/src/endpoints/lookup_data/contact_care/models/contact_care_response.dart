import 'package:equatable/equatable.dart';
import 'contact_care_data.dart';

class ContactCareResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final ContactCareData data;

  ContactCareResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.data,
  });

  ContactCareResponse.empty()
      : data = ContactCareData.empty(),
        responseCode = '',
        responseMessage = '';

  @override
  List<Object?> get props => [responseCode, responseMessage, data];

  factory ContactCareResponse.fromJson(Map<String, dynamic> json) {
    return ContactCareResponse(
      responseCode: json['responseCode'] as String,
      responseMessage: json['responseMessage'] as String,
      data: ContactCareData.fromJson(json['data']),
    );
  }
}
