import 'package:equatable/equatable.dart';

class GetProfileResponseData extends Equatable {
  final int id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String? fullname;
  final String? entityCode;
  final String? email;
  final String? mobileNo;
  final String? userRole;
  final String status;
  final String? branchCode;
  final String? otpLink;
  final String? photoLink;
  final String? identityCardLink;
  final String? bvnCardLink;
  final String bvn;
  final String? city;
  final String? lga;
  final String? state;
  final String? address;
  final String? country;
  final String? language;
  final String? dob;
  final String? lastLoginDate;
  final String? verifyStatus;
  final String? authStatus;
  final String? geolocation;
  final String? identityType;
  final String? identityNo;
  final String? gender;
  final String? supervisor;
  final String? rspCode;
  final String? createdDate;
  final String? businessRegion;
  final String? comment;
  final String? storeCode;
  final String? businessCode;
  final BusinessInfo? business;
  final List<DocumentDetails>? documents;

  GetProfileResponseData(
      {required this.id,
      required this.firstname,
      this.middlename,
      required this.lastname,
      this.fullname,
      this.entityCode,
      this.email,
      this.mobileNo,
      this.userRole,
      required this.status,
      this.language,
      this.lastLoginDate,
      this.country,
      this.address,
      this.lga,
      this.city,
      this.state,
      this.gender,
      this.dob,
      this.verifyStatus,
      this.authStatus,
      this.rspCode,
      required this.bvn,
      this.bvnCardLink,
      this.photoLink,
      this.supervisor,
      this.createdDate,
      this.identityCardLink,
      this.otpLink,
      this.identityType,
      this.identityNo,
      this.businessCode,
      this.branchCode,
      this.businessRegion,
      this.business,
      this.comment,
      this.geolocation,
      this.storeCode,
      this.documents});

  GetProfileResponseData.empty()
      : id = 0,
        firstname = "",
        middlename = "",
        lastname = "",
        fullname = "",
        entityCode = "",
        email = "",
        mobileNo = "",
        userRole = "",
        status = "",
        language = "",
        lastLoginDate = "",
        country = "",
        address = "",
        lga = "",
        city = "",
        state = "",
        gender = "",
        dob = "",
        verifyStatus = "",
        authStatus = "",
        rspCode = "",
        bvn = "",
        bvnCardLink = "",
        photoLink = "",
        supervisor = "",
        createdDate = "",
        identityCardLink = "",
        otpLink = "",
        identityType = "",
        identityNo = "",
        businessCode = "",
        branchCode = "",
        businessRegion = "",
        business = BusinessInfo.empty(),
        comment = null,
        geolocation = "",
        storeCode = null,
        documents = [];

  factory GetProfileResponseData.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseData(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      middlename: json["middlename"],
      lastname: json['lastname'],
      fullname: json['fullname'] as String?,
      entityCode: json['entityCode'] as String?,
      email: json['email'],
      mobileNo: json['mobileNo'],
      userRole: json['userRole'],
      status: json['status'],
      language: json['language'],
      lastLoginDate: json['lastLoginDate'],
      country: json['country'],
      address: json['address'],
      lga: json['lga'],
      city: json['city'],
      state: json['state'],
      gender: json['gender'],
      dob: json['dob'],
      verifyStatus: json['verifyStatus'],
      authStatus: json['authStatus'],
      rspCode: json['rspCode'],
      bvn: json['bvn'],
      photoLink: json['photoLink'],
      business: json['business'] == null
          ? null
          : BusinessInfo.fromJson(json['business']),
      businessCode: json['businessCode'],
      documents: json["documents"] == null
          ? []
          : (json["documents"] as List)
              .map((e) => DocumentDetails.fromJson(e))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstname,
        middlename,
        lastname,
        fullname,
        entityCode,
        email,
        mobileNo,
        userRole,
        status,
        language,
        lastLoginDate,
      ];
}

class BusinessInfo {
  final String? primaryAccountNo;
  final String? businessEmail;
  final String? businessMobileNo;
  final String? businessCode;
  final String? businessLogo;
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

  BusinessInfo({
    this.primaryAccountNo,
    this.businessEmail,
    this.businessMobileNo,
    this.businessCode,
    this.businessLogo,
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

  BusinessInfo.empty()
      : primaryAccountNo = '',
        businessEmail = '',
        businessMobileNo = '',
        businessCode = '',
        businessLogo = '',
        businessName = '',
        businessType = '',
        businessSector = '',
        businessAddress = '',
        state = '',
        lga = '',
        country = '',
        businessStartYear = '',
        businessStartMonth = '',
        registeredName = '';

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        primaryAccountNo: json["primaryAccountNo"],
        businessEmail: json["businessEmail"],
        businessMobileNo: json["businessMobileNo"],
        businessCode: json["businessCode"],
        businessLogo: json["businessLogo"],
        businessName: json["businessName"],
        businessType: json["businessType"],
        businessSector: json["businessSector"],
        businessAddress: json["businessAddress"],
        state: json["state"],
        lga: json["lga"],
        country: json["country"],
        businessStartYear: json["businessStartYear"],
        businessStartMonth: json["businessStartMonth"],
        registeredName: json["registeredName"],
      );
}

class DocumentDetails {
  final int? id;
  final String? entityCode;
  final String? username;
  final String? documentType;
  final String? documentName;
  final String? documentPath;
  final String? accountNo;
  final String? documentTitle;
  final String? verifiedStatus;
  final String? verifiedBy;
  final String? comment;
  final String? documentImg;

  DocumentDetails({
    this.id,
    this.entityCode,
    this.username,
    this.documentType,
    this.documentName,
    this.documentPath,
    this.accountNo,
    this.documentTitle,
    this.verifiedStatus,
    this.verifiedBy,
    this.comment,
    this.documentImg,
  });

  DocumentDetails.empty()
      : id = null,
        entityCode = '',
        username = '',
        documentType = '',
        documentName = '',
        documentPath = '',
        accountNo = '',
        documentTitle = '',
        verifiedStatus = '',
        verifiedBy = '',
        comment = '',
        documentImg = '';

  factory DocumentDetails.fromJson(Map<String, dynamic> json) =>
      DocumentDetails(
        id: json["id"],
        entityCode: json["entityCode"],
        username: json["username"],
        documentType: json["documentType"],
        documentName: json["documentName"],
        documentPath: json["documentPath"],
        accountNo: json["accountNo"],
        documentTitle: json["documentTitle"],
        verifiedStatus: json["verifiedStatus"],
        verifiedBy: json["verifiedBy"],
        comment: json["comment"],
        documentImg: json["documentImg"],
      );
}
