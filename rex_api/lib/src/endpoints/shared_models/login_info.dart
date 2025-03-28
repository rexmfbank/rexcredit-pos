import 'package:equatable/equatable.dart';

class LoginInfo extends Equatable {
  final String username;
  final String userID;
  final String pwd;
  final String userRole;
  final String entityCode;
  final String entityName;
  final String entityLogo;
  final String entityStyle;
  final String language;
  final String entityType;
  final int retryNumber;
  final String tickedID;
  final String medium;
  final String deviceID;
  final String responseMessage;
  final String responseCode;
  final String fullname;
  final String email;
  final String mobileNo;
  final String lastLoginDate;
  final String photoLinks;
  final String firstname;
  final String branchName;
  final String branchID;
  final String ccy;
  final String country;
  final String supervisor;
  final String expiryDate;
  final String terminalId;
  final String forcePwdChange;
  final String address;
  final String refreshToken;

  const LoginInfo({
    required this.username,
    required this.userID,
    required this.pwd,
    required this.userRole,
    required this.entityCode,
    required this.entityName,
    required this.entityLogo,
    required this.entityStyle,
    required this.language,
    required this.entityType,
    required this.retryNumber,
    required this.tickedID,
    required this.medium,
    required this.deviceID,
    required this.responseMessage,
    required this.responseCode,
    required this.fullname,
    required this.email,
    required this.mobileNo,
    required this.lastLoginDate,
    required this.photoLinks,
    required this.firstname,
    required this.branchName,
    required this.branchID,
    required this.ccy,
    required this.country,
    required this.supervisor,
    required this.expiryDate,
    required this.terminalId,
    required this.forcePwdChange,
    required this.address,
    required this.refreshToken,
  });

  const LoginInfo.empty()
      : username = '',
        userID = '',
        pwd = '',
        userRole = '',
        entityCode = '',
        entityName = '',
        entityLogo = '',
        entityStyle = '',
        language = '',
        entityType = '',
        retryNumber = 0,
        tickedID = '',
        medium = '',
        deviceID = '',
        responseMessage = '',
        responseCode = '',
        fullname = '',
        email = '',
        mobileNo = '',
        lastLoginDate = '',
        photoLinks = '',
        firstname = '',
        branchName = '',
        branchID = '',
        ccy = '',
        country = '',
        supervisor = '',
        expiryDate = '',
        terminalId = '',
        forcePwdChange = '',
        address = '',
        refreshToken = '';

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      username: json['username'] as String,
      userID: json['userID'] as String,
      pwd: json['pwd'] as String,
      userRole: json['userRole'] as String,
      entityCode: json['entityCode'] as String,
      entityName: json['entityName'] as String,
      entityLogo: json['entityLogo'] as String,
      entityStyle: json['entityStyle'] as String,
      language: json['language'] as String,
      entityType: json['entityType'] as String,
      retryNumber: json['retryNo'] as int,
      tickedID: json['tickedID'] as String,
      medium: json['medium'] as String,
      deviceID: json['deviceID'] as String,
      responseMessage: json['responseMessage'] as String,
      responseCode: json['responseCode'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      mobileNo: json['mobileNo'] as String,
      lastLoginDate: json['lastLoginDate'] as String,
      photoLinks: json['photoLinks'] as String,
      firstname: json['firstname'] as String,
      branchName: json['branchName'] as String,
      branchID: json['branchID'] as String,
      ccy: json['ccy'] as String,
      country: json['country'] as String,
      supervisor: json['supervisor'] as String,
      expiryDate: json['expiryDate'] as String,
      terminalId: json['terminalId'] as String,
      forcePwdChange: json['forcePwdChange'] as String,
      address: json['address'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "LoginInfo",
        "username": "string",
        "userID": "string",
        "pwd": "string",
        "userRole": "string",
        "entityCode": "string",
        "entityName": "string",
        "entityLogo": "string",
        "entityStyle": "string",
        "language": "string",
        "entityType": "string",
        "retryNo": 0,
        "ticketID": "string",
        "medium": "string",
        "deviceID": "string",
        "responseMessage": "string",
        "responseCode": "string",
        "fullname": "string",
        "email": "string",
        "mobileNo": "string",
        "lastLoginDate": "string",
        "photoLinks": "string",
        "firstname": "string",
        "branchName": "string",
        "branchID": "string",
        "ccy": "string",
        "country": "string",
        "supervisor": "string",
        "expiryDate": "string",
        "terminalId": "string",
        "forcePwdChange": "string",
        "address": "string",
        "refreshToken": "string"
      }.toString();

  @override
  List<Object?> get props => [
        username,
        userID,
        pwd,
        userRole,
        entityCode,
        entityName,
        entityLogo,
        entityStyle,
        language,
        entityType,
        retryNumber,
        tickedID,
        medium,
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
        supervisor,
        expiryDate,
        terminalId,
        forcePwdChange,
        address,
        refreshToken,
      ];
}
