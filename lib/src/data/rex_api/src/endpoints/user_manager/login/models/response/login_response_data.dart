import 'package:equatable/equatable.dart';

import 'app_menu_dto.dart';

class LoginResponseData extends Equatable {
  final String? username;
  final String? pwd;
  final String? userRole;
  final String? myReferralCode;
  final String? entityCode;
  final String? entityName;
  final String? entityLogo;
  final String? language;
  final String? entityType;
  final int retryNumber;
  final String? ticketID;
  final String? deviceID;
  final String responseMessage;
  final String responseCode;
  final String? fullname;
  final String? email;
  final String? mobileNo;
  final String? lastLoginDate;
  final String? photoLinks;
  final String? firstname;
  final String? branchName;
  final String? branchID;
  final String? ccy;
  final String? country;
  final String? expiryDate;
  final String? terminalId;
  final String? forcePwdChange;
  final String? address;
  final String? gender;
  final String? dob;
  final String? refreshToken;
  final String? primaryAccountNo;
  final String? businessCode;
  final String? storeCode;
  final String? customerType;
  final double? withdrawalLimit;
  final bool? pendingKycDocument;
  final List<AppMenuDto>? appMenu;

  const LoginResponseData({
    this.username,
    this.pwd,
    this.userRole,
    this.myReferralCode,
    this.entityCode,
    this.entityName,
    this.entityLogo,
    this.language,
    this.entityType,
    required this.retryNumber,
    this.ticketID,
    this.deviceID,
    required this.responseMessage,
    required this.responseCode,
    this.fullname,
    this.email,
    this.mobileNo,
    this.lastLoginDate,
    this.photoLinks,
    this.firstname,
    this.branchName,
    this.branchID,
    this.ccy,
    this.country,
    this.expiryDate,
    this.terminalId,
    this.forcePwdChange,
    this.address,
    this.gender,
    this.dob,
    this.refreshToken,
    this.primaryAccountNo,
    this.businessCode,
    this.storeCode,
    this.customerType,
    this.withdrawalLimit,
    this.pendingKycDocument,
    this.appMenu,
  });

  const LoginResponseData.empty()
      : username = null,
        pwd = null,
        userRole = null,
        myReferralCode = null,
        entityCode = null,
        entityName = null,
        entityLogo = null,
        language = null,
        entityType = null,
        retryNumber = 0,
        ticketID = null,
        deviceID = null,
        responseMessage = '',
        responseCode = '',
        fullname = '',
        email = null,
        mobileNo = null,
        lastLoginDate = null,
        photoLinks = null,
        firstname = null,
        branchName = null,
        branchID = null,
        ccy = null,
        country = null,
        expiryDate = null,
        terminalId = null,
        forcePwdChange = null,
        address = null,
        gender = null,
        dob = "",
        refreshToken = null,
        primaryAccountNo = null,
        businessCode = null,
        storeCode = null,
        customerType = null,
        pendingKycDocument = false,
        appMenu = const [],
        withdrawalLimit = null;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      username: json['username'] as String?,
      pwd: json['pwd'] as String?,
      userRole: json['userRole'] as String?,
      myReferralCode: json['myReferralCode'] as String?,
      entityCode: json['entityCode'] as String?,
      entityName: json['entityName'] as String?,
      entityLogo: json['entityLogo'] as String?,
      language: json['language'] as String?,
      entityType: json['entityType'] as String?,
      retryNumber: json['retryNo'] as int,
      ticketID: json['ticketID'] as String?,
      deviceID: json['deviceID'] as String?,
      responseMessage: json['responseMessage'] as String,
      responseCode: json['responseCode'] as String,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      mobileNo: json['mobileNo'] as String?,
      lastLoginDate: json['lastLoginDate'] as String?,
      photoLinks: json['photoLinks'] as String?,
      firstname: json['firstname'] as String?,
      branchName: json['branchName'] as String?,
      branchID: json['branchID'] as String?,
      ccy: json['ccy'] as String?,
      country: json['country'] as String?,
      expiryDate: json['expiryDate'] as String?,
      terminalId: json['terminalId'] as String?,
      forcePwdChange: json['forcePwdChange'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      refreshToken: json['refreshToken'] as String?,
      primaryAccountNo: json['primaryAccountNo'] as String?,
      businessCode: json['businessCode'] as String?,
      storeCode: json['storeCode'] as String?,
      customerType: json['customerType'] as String?,
      pendingKycDocument: json['pendingKycDocument'],
      withdrawalLimit: json['withdrawalLimit'] as double?,
      appMenu: json["appMenuList"] == null
          ? []
          : List<AppMenuDto>.from(
              json["appMenuList"]!.map((x) => AppMenuDto.fromJson(x))),
    );
  }

  @override
  String toString() => {
        "CLASS": "LoginResponseData",
        "username": username,
        "pwd": pwd,
        "userRole": userRole,
        "myReferralCode": myReferralCode,
        "entityCode": entityCode,
        "entityName": entityName,
        "entityLogo": entityLogo,
        "language": language,
        "entityType": entityType,
        "retryNo": retryNumber,
        "ticketID": ticketID,
        "deviceID": deviceID,
        "responseMessage": responseMessage,
        "responseCode": responseCode,
        "fullname": fullname,
        "email": email,
        "mobileNo": mobileNo,
        "lastLoginDate": lastLoginDate,
        "photoLinks": photoLinks,
        "firstname": firstname,
        "branchName": branchName,
        "branchID": branchID,
        "ccy": ccy,
        "country": country,
        "expiryDate": expiryDate,
        "terminalId": terminalId,
        "forcePwdChange": forcePwdChange,
        "address": address,
        "gender": gender,
        "dob": dob,
        "refreshToken": refreshToken,
        "primaryAccountNo": primaryAccountNo,
        "businessCode": businessCode,
        "storeCode": storeCode,
        "customerType": customerType,
        "withdrawalLimit": withdrawalLimit,
        "appMenuList": appMenu,
      }.toString();

  @override
  List<Object?> get props => [
        username,
        pwd,
        userRole,
        myReferralCode,
        entityCode,
        entityName,
        entityLogo,
        language,
        entityType,
        retryNumber,
        ticketID,
        deviceID,
        responseMessage,
        responseCode,
        fullname,
        email,
        mobileNo,
        lastLoginDate,
        photoLinks,
        firstname,
        branchName,
        branchID,
        ccy,
        country,
        expiryDate,
        terminalId,
        forcePwdChange,
        address,
        gender,
        refreshToken,
        primaryAccountNo,
        businessCode,
        storeCode,
        customerType,
        appMenu,
      ];
}
