import 'package:equatable/equatable.dart';

class OnboardBusinessInfoResponse extends Equatable {
  final String responseCode;
  final String responseMessage;
  final String? entityCode;
  final OnboardBusinessInfo data;

  const OnboardBusinessInfoResponse({
    required this.responseCode,
    required this.responseMessage,
    this.entityCode,
    required this.data,
  });

  factory OnboardBusinessInfoResponse.fromJson(Map<String, dynamic> json) {
    return OnboardBusinessInfoResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      entityCode: json['entityCode'],
      data: OnboardBusinessInfo.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "entityCode": entityCode,
        "data": data.toJson(),
      };

  @override
  String toString() => "OnboardBusinessInfoResponse: ${toJson()}";

  @override
  List<Object?> get props => [
        responseCode,
        responseMessage,
        entityCode,
        data,
      ];
}

class OnboardBusinessInfo extends Equatable {
  final String? businessName;
  final String? businessType;
  final String? entityCode;
  final String? businessCode;
  final String? businessSector;
  final String? businessAddress;
  final String? businessRegNumber;
  final String? businessEmail;
  final String? businessTaxId;
  final String? businessMobileNo;
  final int? yearsInBusiness;
  final List<OnboardBusinessDocs>? documents;
  final List? directors;

  const OnboardBusinessInfo({
    this.businessName,
    this.businessType,
    this.entityCode,
    this.businessCode,
    this.businessSector,
    this.businessAddress,
    this.businessRegNumber,
    this.businessEmail,
    this.businessTaxId,
    this.businessMobileNo,
    this.yearsInBusiness,
    this.documents,
    this.directors,
  });

  factory OnboardBusinessInfo.fromJson(Map<String, dynamic> json) {
    return OnboardBusinessInfo(
      businessName: json['businessName'] as String?,
      businessType: json['businessType'] as String?,
      entityCode: json['entityCode'] as String?,
      businessCode: json['businessCode'] as String?,
      businessSector: json['businessSector'] as String?,
      businessAddress: json['businessAddress'] as String?,
      businessRegNumber: json['businessRegNo'] as String?,
      businessEmail: json['businessEmaill'] as String?,
      businessTaxId: json['businessTaxId'] as String?,
      businessMobileNo: json['businessMobileNo'] as String?,
      yearsInBusiness: json['noOfYearsInBusiness'] as int?,
      documents: json['documentInfos'] == null
          ? null
          : List.from(
              json['documentInfos'].map((e) => OnboardBusinessDocs.fromJson(e)),
            ),
      directors: json['businessDirectorDtos'],
    );
  }

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "businessType": businessType,
        "entityCode": entityCode,
        "businessCode": businessCode,
        "businessSector": businessSector,
        "businessAddress": businessAddress,
        "businessRegNo": businessRegNumber,
        "businessEmail": businessEmail,
        "businessTaxId": businessTaxId,
        "businessMobileNo": businessMobileNo,
        "yearsInBusiness": yearsInBusiness,
        "documentInfos": documents,
        "businessDirectorDtos": directors,
      };

  @override
  String toString() => "OnboardBusinessInfo ${toJson()}";

  @override
  List<Object?> get props => [
        businessName,
        businessType,
        entityCode,
        businessCode,
        businessSector,
        businessAddress,
        businessRegNumber,
        businessEmail,
        businessTaxId,
        businessMobileNo,
        yearsInBusiness,
        documents,
        directors,
      ];
}

class OnboardBusinessDocs extends Equatable {
  final int? id;
  final String? entityCode;
  final String? username;
  final String? documentType;
  final String? documentName;
  final String? documentPath;
  final String? accountNumber;
  final String? documentTitle;
  final String? verifiedStatus;
  final String? verifiedBy;
  final String? comment;
  final String? documentImg;
  final Object? data;

  const OnboardBusinessDocs({
    this.id,
    this.entityCode,
    this.username,
    this.documentType,
    this.documentName,
    this.documentPath,
    this.accountNumber,
    this.documentTitle,
    this.verifiedStatus,
    this.verifiedBy,
    this.comment,
    this.documentImg,
    this.data,
  });

  factory OnboardBusinessDocs.fromJson(Map<String, dynamic> json) {
    return OnboardBusinessDocs(
      id: json['id'] as int?,
      entityCode: json['entityCode'] as String?,
      username: json['username'] as String?,
      documentType: json['documentType'] as String?,
      documentName: json['documentName'] as String?,
      documentPath: json['documentPath'] as String?,
      accountNumber: json['accountNo'] as String?,
      documentTitle: json['documentTitle'] as String?,
      verifiedStatus: json['verifiedStatus'] as String?,
      verifiedBy: json['verifiedBy'] as String?,
      comment: json['comment'] as String?,
      documentImg: json['documentImg'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "entityCode": entityCode,
        "username": username,
        "documentType": documentType,
        "documentName": documentName,
        "documentPath": documentPath,
        "accountNo": accountNumber,
        "documentTitle": documentTitle,
        "verifiedStatus": verifiedStatus,
        "verifiedBy": verifiedBy,
        "comment": comment,
        "documentImg": documentImg,
        "data": data,
      };

  @override
  String toString() => "OnboardBusinessDocs: ${toJson()}";

  @override
  List<Object?> get props => [
        id,
        entityCode,
        username,
        documentType,
        documentName,
        documentPath,
        accountNumber,
        documentTitle,
        verifiedStatus,
        verifiedBy,
        comment,
        documentImg,
        data,
      ];
}
