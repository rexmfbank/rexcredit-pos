import 'package:equatable/equatable.dart';

class UpdateBusinessInfoResponseData extends Equatable {
  final String primaryAccountNo;
  final String? businessEmail;
  final String? businessMobileNo;
  final String? businessCode;
  final String? logo;
  final String? businessName;
  final String? businessType;
  final String? businessSector;
  final String? businessAddress;
  final String? state;
  final String? lga;
  final String? country;
  final String? businessStartYear;
  final String? businessStartMonth;
  final String? registeredName;

  UpdateBusinessInfoResponseData({
    required this.primaryAccountNo,
    this.businessEmail,
    this.businessMobileNo,
    this.businessCode,
    this.logo,
    this.businessName,
    this.businessType,
    this.businessSector,
    this.businessAddress,
    this.state,
    this.lga,
    this.country,
    this.businessStartYear,
    this.businessStartMonth,
    this.registeredName,
  });

  const UpdateBusinessInfoResponseData.empty()
      : primaryAccountNo = '',
        businessEmail = '',
        businessMobileNo = '',
        businessCode = '',
        logo = '',
        businessName = '',
        businessType = '',
        businessSector = '',
        businessAddress = '',
        state = '',
        lga = '',
        country = '',
        businessStartMonth = '',
        businessStartYear = '',
        registeredName = '';

  factory UpdateBusinessInfoResponseData.fromJson(Map<String, dynamic> json) {
    return UpdateBusinessInfoResponseData(
      primaryAccountNo: json['primaryAccountNo'] as String,
      businessEmail: json['businessEmail'] as String?,
      businessMobileNo: json['businessMobileNo'] as String?,
      businessCode: json['businessCode'] as String?,
      logo: json['logo'] as String?,
      businessName: json['businessName'] as String?,
      businessType: json['businessType'] as String?,
      businessSector: json['businessSector'] as String?,
      businessAddress: json['businessAddress'] as String?,
      state: json['state'] as String?,
      lga: json['lga'],
      country: json['country'],
      businessStartYear: json['businessStartYear'],
      businessStartMonth: json['businessStartMonth'],
      registeredName: json['registeredName'],
    );
  }

  @override
  List<Object?> get props => [
        primaryAccountNo,
        businessEmail,
        businessMobileNo,
        businessCode,
        logo,
        businessName,
        businessType,
        businessSector,
        businessAddress,
        state,
        lga,
        country,
        businessStartMonth,
        businessStartYear,
        registeredName,
      ];
}
