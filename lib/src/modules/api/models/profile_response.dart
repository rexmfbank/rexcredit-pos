import 'package:equatable/equatable.dart';

class ProfileResponse extends Equatable {
  const ProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final ProfileResData? data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : ProfileResData.fromJson(json["data"]),
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

class ProfileResData extends Equatable {
  const ProfileResData({required this.profiles});

  final List<Profile> profiles;

  factory ProfileResData.fromJson(Map<String, dynamic> json) {
    return ProfileResData(
      profiles:
          json["profiles"] == null
              ? []
              : List<Profile>.from(
                json["profiles"]!.map((x) => Profile.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "profiles": profiles.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [profiles];
}

class Profile extends Equatable {
  const Profile({
    required this.accountNumber,
    required this.accountType,
    required this.accountName,
    required this.availableBalance,
    required this.borrower,
    required this.business,
    required this.completion,
  });

  final String? accountNumber;
  final String? accountType;
  final String? accountName;
  final String? availableBalance;
  final Borrower? borrower;
  final Business? business;
  final Completion? completion;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      accountNumber: json["account_number"],
      accountType: json["account_type"],
      accountName: json["account_name"],
      availableBalance: json["available_balance"],
      borrower:
          json["borrower"] == null ? null : Borrower.fromJson(json["borrower"]),
      business:
          json["business"] == null ? null : Business.fromJson(json["business"]),
      completion:
          json["completion"] == null
              ? null
              : Completion.fromJson(json["completion"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "account_type": accountType,
    "account_name": accountName,
    "available_balance": availableBalance,
    "borrower": borrower?.toJson(),
    "business": business?.toJson(),
    "completion": completion?.toJson(),
  };

  @override
  List<Object?> get props => [
    accountNumber,
    accountType,
    accountName,
    availableBalance,
    borrower,
    business,
    completion,
  ];
}

class Borrower extends Equatable {
  const Borrower({
    required this.borrowerId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.city,
    required this.state,
    required this.lga,
    required this.address,
    required this.creditScore,
    required this.customerType,
    required this.kycStatus,
    required this.kycTier,
    required this.status,
    required this.photo,
    required this.photoUrl,
    required this.photoPath,
  });

  final String? borrowerId;
  final String? firstName;
  final dynamic middleName;
  final String? lastName;
  final dynamic gender;
  final String? email;
  final String? phone;
  final String? city;
  final String? state;
  final dynamic lga;
  final String? address;
  final dynamic creditScore;
  final String? customerType;
  final String? kycStatus;
  final num? kycTier;
  final String? status;
  final String? photo;
  final String? photoUrl;
  final String? photoPath;

  factory Borrower.fromJson(Map<String, dynamic> json) {
    return Borrower(
      borrowerId: json["borrower_id"],
      firstName: json["first_name"],
      middleName: json["middle_name"],
      lastName: json["last_name"],
      gender: json["gender"],
      email: json["email"],
      phone: json["phone"],
      city: json["city"],
      state: json["state"],
      lga: json["lga"],
      address: json["address"],
      creditScore: json["credit_score"],
      customerType: json["customer_type"],
      kycStatus: json["kyc_status"],
      kycTier: json["kyc_tier"],
      status: json["status"],
      photo: json["photo"],
      photoUrl: json["photo_url"],
      photoPath: json["photo_path"],
    );
  }

  Map<String, dynamic> toJson() => {
    "borrower_id": borrowerId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "gender": gender,
    "email": email,
    "phone": phone,
    "city": city,
    "state": state,
    "lga": lga,
    "address": address,
    "credit_score": creditScore,
    "customer_type": customerType,
    "kyc_status": kycStatus,
    "kyc_tier": kycTier,
    "status": status,
    "photo": photo,
    "photo_url": photoUrl,
    "photo_path": photoPath,
  };

  @override
  List<Object?> get props => [
    borrowerId,
    firstName,
    middleName,
    lastName,
    gender,
    email,
    phone,
    city,
    state,
    lga,
    address,
    creditScore,
    customerType,
    kycStatus,
    kycTier,
    status,
    photo,
    photoUrl,
    photoPath,
  ];
}

class Business extends Equatable {
  const Business({
    required this.businessId,
    required this.businessName,
    required this.businessType,
    required this.industry,
    required this.businessAddress,
    required this.status,
    required this.cacRegno,
    required this.dateOfIncorporation,
    required this.website,
    required this.city,
    required this.state,
    required this.lga,
    required this.taxId,
    required this.logo,
    required this.yearsAtOfficeLocation,
    required this.nextOfKinName,
    required this.nextOfKinPhone,
    required this.nextOfKinRelationship,
  });

  final String? businessId;
  final String? businessName;
  final String? businessType;
  final String? industry;
  final String? businessAddress;
  final String? status;
  final String? cacRegno;
  final DateTime? dateOfIncorporation;
  final String? website;
  final dynamic city;
  final String? state;
  final String? lga;
  final String? taxId;
  final String? logo;
  final String? yearsAtOfficeLocation;
  final String? nextOfKinName;
  final String? nextOfKinPhone;
  final String? nextOfKinRelationship;

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessId: json["business_id"],
      businessName: json["business_name"],
      businessType: json["business_type"],
      industry: json["industry"],
      businessAddress: json["business_address"],
      status: json["status"],
      cacRegno: json["cac_regno"],
      dateOfIncorporation: DateTime.tryParse(
        json["date_of_incorporation"] ?? "",
      ),
      website: json["website"],
      city: json["city"],
      state: json["state"],
      lga: json["lga"],
      taxId: json["tax_id"],
      logo: json["logo"],
      yearsAtOfficeLocation: json["years_at_office_location"],
      nextOfKinName: json["next_of_kin_name"],
      nextOfKinPhone: json["next_of_kin_phone"],
      nextOfKinRelationship: json["next_of_kin_relationship"],
    );
  }

  Map<String, dynamic> toJson() => {
    "business_id": businessId,
    "business_name": businessName,
    "business_type": businessType,
    "industry": industry,
    "business_address": businessAddress,
    "status": status,
    "cac_regno": cacRegno,
    "date_of_incorporation": dateOfIncorporation?.toIso8601String(),
    "website": website,
    "city": city,
    "state": state,
    "lga": lga,
    "tax_id": taxId,
    "logo": logo,
    "years_at_office_location": yearsAtOfficeLocation,
    "next_of_kin_name": nextOfKinName,
    "next_of_kin_phone": nextOfKinPhone,
    "next_of_kin_relationship": nextOfKinRelationship,
  };

  @override
  List<Object?> get props => [
    businessId,
    businessName,
    businessType,
    industry,
    businessAddress,
    status,
    cacRegno,
    dateOfIncorporation,
    website,
    city,
    state,
    lga,
    taxId,
    logo,
    yearsAtOfficeLocation,
    nextOfKinName,
    nextOfKinPhone,
    nextOfKinRelationship,
  ];
}

class Completion extends Equatable {
  const Completion({
    required this.percentage,
    required this.totalItems,
    required this.completedCount,
    required this.completedItems,
    required this.pendingItems,
    required this.pendingUploadedDocuments,
  });

  final num? percentage;
  final num? totalItems;
  final num? completedCount;
  final List<String> completedItems;
  final List<dynamic> pendingItems;
  final List<dynamic> pendingUploadedDocuments;

  factory Completion.fromJson(Map<String, dynamic> json) {
    return Completion(
      percentage: json["percentage"],
      totalItems: json["total_items"],
      completedCount: json["completed_count"],
      completedItems:
          json["completed_items"] == null
              ? []
              : List<String>.from(json["completed_items"]!.map((x) => x)),
      pendingItems:
          json["pending_items"] == null
              ? []
              : List<dynamic>.from(json["pending_items"]!.map((x) => x)),
      pendingUploadedDocuments:
          json["pending_uploaded_documents"] == null
              ? []
              : List<dynamic>.from(
                json["pending_uploaded_documents"]!.map((x) => x),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
    "total_items": totalItems,
    "completed_count": completedCount,
    "completed_items": completedItems.map((x) => x).toList(),
    "pending_items": pendingItems.map((x) => x).toList(),
    "pending_uploaded_documents":
        pendingUploadedDocuments.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [
    percentage,
    totalItems,
    completedCount,
    completedItems,
    pendingItems,
    pendingUploadedDocuments,
  ];
}
