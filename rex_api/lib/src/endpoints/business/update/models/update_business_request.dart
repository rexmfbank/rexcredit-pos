import 'package:equatable/equatable.dart';

class UpdateBusinessRequest extends Equatable {
  final String? businessCode;
  final String? logo;
  final String name;
  final String type;
  final String sector;
  final String address;
  final String emailAddress;
  final String mobileNo;
  final String state;
  final String lga;
  final String country;
  final int startYear;
  final int startMonth;

  UpdateBusinessRequest(
      {
        this.businessCode,
        this.logo,
        required this.name,
        required this.type,
        required this.sector,
        required this.address,
        required this.emailAddress,
        required this.mobileNo,
        required this.state,
        required this.lga,
        required this.country,
        required this.startYear,
        required this.startMonth
      });

  Map<String, dynamic> toJson() {
    return {
      'businessCode': businessCode,
      'logo': logo,
      'name': name,
      'type': type,
      'sector': sector,
      'address': address,
      'emailAddress': emailAddress,
      'state': state,
      'lga': lga,
      'country': country,
      'startYear': startYear,
      'mobileNo': mobileNo,
      'startMonth': startMonth
    };
  }

  @override
  List<Object?> get props => [
        businessCode,
        logo,
        name,
        type,
        sector,
        address,
        emailAddress,
        mobileNo,
        state,
        lga,
        country,
        startYear,
        startMonth
      ];
}
