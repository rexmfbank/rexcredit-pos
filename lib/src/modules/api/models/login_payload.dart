import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  const LoginRequest({required this.email, required this.password});

  final String? email;
  final String? password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  @override
  List<Object?> get props => [email, password];
}

class LoginResponse extends Equatable {
  const LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final LoginResponseData? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null
              ? null
              : LoginResponseData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  List<Object?> get props => [status, message, data];
}

class LoginResponseData extends Equatable {
  const LoginResponseData({
    required this.companyId,
    required this.branchId,
    required this.borrowerId,
    required this.phone,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.idType,
    required this.idValue,
    required this.kycTier,
    required this.customerType,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.kycStatus,
    required this.photo,
    required this.pinSet,
    required this.totpEnabled,
    required this.deviceBound,
    required this.registrationStep,
  });

  final int? companyId;
  final int? branchId;
  final int? borrowerId;
  final String? phone;
  final String? status;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? idType;
  final String? idValue;
  final num? kycTier;
  final String? customerType;
  final String? accessToken;
  final String? tokenType;
  final num? expiresIn;
  final String? kycStatus;
  final String? photo;
  final bool? pinSet;
  final bool? totpEnabled;
  final bool? deviceBound;
  final String? registrationStep;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      companyId: json["company_id"],
      branchId: json["branch_id"],
      borrowerId: json["borrower_id"],
      phone: json["phone"],
      status: json["status"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      idType: json["id_type"],
      idValue: json["id_value"],
      kycTier: json["kyc_tier"],
      customerType: json["customer_type"],
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      kycStatus: json["kyc_status"],
      photo: json["photo"],
      pinSet: json["pin_set"],
      totpEnabled: json["totp_enabled"],
      deviceBound: json["device_bound"],
      registrationStep: json["registration_step"],
    );
  }

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "branch_id": branchId,
    "borrower_id": borrowerId,
    "phone": phone,
    "status": status,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "id_type": idType,
    "id_value": idValue,
    "kyc_tier": kycTier,
    "customer_type": customerType,
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "kyc_status": kycStatus,
    "photo": photo,
    "pin_set": pinSet,
    "totp_enabled": totpEnabled,
    "device_bound": deviceBound,
    "registration_step": registrationStep,
  };

  @override
  List<Object?> get props => [
    companyId,
    branchId,
    borrowerId,
    phone,
    status,
    firstName,
    lastName,
    email,
    idType,
    idValue,
    kycTier,
    customerType,
    accessToken,
    tokenType,
    expiresIn,
    kycStatus,
    photo,
    pinSet,
    totpEnabled,
    deviceBound,
    registrationStep,
  ];
}
