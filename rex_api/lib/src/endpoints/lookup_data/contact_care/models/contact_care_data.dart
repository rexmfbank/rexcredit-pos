import 'package:equatable/equatable.dart';

class ContactCareData extends Equatable {
  final String email;
  final String phoneNo;
  final String whatsAppNo;
  final String? website;

  ContactCareData({
    required this.email,
    required this.phoneNo,
    required this.whatsAppNo,
    required this.website,
  });

  const ContactCareData.empty()
      : email = '',
        phoneNo = '',
        whatsAppNo = '',
        website = '';

  factory ContactCareData.fromJson(Map<String, dynamic> json) {
    return ContactCareData(
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      whatsAppNo: json['whatsAppNo'] as String,
      website: json['website'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        email,
        phoneNo,
        whatsAppNo,
        website,
      ];
}
