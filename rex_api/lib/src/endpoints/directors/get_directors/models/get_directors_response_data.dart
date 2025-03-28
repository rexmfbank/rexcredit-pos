import 'package:equatable/equatable.dart';

class GetDirectorsResponseData extends Equatable {
  final int directorId;
  final String? name;
  final String email;
  final String sharePercent;
  final String businessCode;
  final String bvn;
  final String mobileNo;
  final String? address;
  final String createdDate;

  GetDirectorsResponseData(
      {required this.directorId,
      this.name,
      required this.email,
      required this.sharePercent,
      required this.businessCode,
      required this.bvn,
      required this.mobileNo,
      this.address,
      required this.createdDate});

  GetDirectorsResponseData.empty()
      : directorId = 0,
        name = null,
        email = '',
        sharePercent = '',
        businessCode = '',
        bvn = '',
        mobileNo = '',
        address = '',
        createdDate = '';

  factory GetDirectorsResponseData.fromJson(Map<String, dynamic> json) {
    return GetDirectorsResponseData(
      directorId: json['directorId'],
      name: json['name'] as String?,
      email: json['email'] as String,
      sharePercent: json['sharePercent'] as String,
      businessCode: json['businessCode'] as String,
      bvn: json['bvn'] as String,
      mobileNo: json['mobileNo'] as String,
      address: json['address'] as String?,
      createdDate: json['createdDate']
    );
  }

  @override
  List<Object?> get props => [
        directorId,
        name,
        email,
        sharePercent,
        businessCode,
        bvn,
        mobileNo,
        address,
        createdDate
      ];
}
