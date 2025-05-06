class LoanApplicationInitiatedRequest {
  // final String? productCode;
  final String? loanTitle;
  final String? section;
  final String? loanRefNo;
  final String? reason;
  final double? amountApplied;
  final int? tenor;
  final String? purpose;
  final String? status;
  final String? maritalStatus;
  final String? residentialAddress;
  final String? inResidenceSince;
  final int? noOfDependants;
  final String? educationalStatus;
  final String? employmentStatus;
  // final String? employerName;
  // final String? monthlyIncome;
  // final String? employerState;
  // final String? employerStateLga;
  // final String? employmentStartDate;
  // final String? workEmail;
  // final String? guarantorFirstName;
  // final String? guarantorLastName;
  // final String? guarantorRelationship;
  // final String? guarantorEmail;
  // final String? guarantorPhoneNumber;
  // final String? industry;
  // final String? sector;

  LoanApplicationInitiatedRequest({
    // this.productCode,
    this.loanTitle,
    this.section,
    this.loanRefNo,
    this.reason,
    this.amountApplied,
    this.tenor,
    this.purpose,
    this.status,
    this.maritalStatus,
    this.residentialAddress,
    this.inResidenceSince,
    this.noOfDependants,
    this.educationalStatus,
    this.employmentStatus,
    // this.employerName,
    // this.monthlyIncome,
    // this.employerState,
    // this.employerStateLga,
    // this.employmentStartDate,
    // this.industry,
    // this.sector,
    // this.workEmail,
    // this.guarantorFirstName,
    // this.guarantorLastName,
    // this.guarantorRelationship,
    // this.guarantorEmail,
    // this.guarantorPhoneNumber,
  });

  Map<String, dynamic> toJson() => {
        // "productCode": productCode,
        "loanTitle": loanTitle,
        "section": section,
        "loanRefNo": loanRefNo,
        "reason": reason,
        "amountApplied": amountApplied,
        "tenor": tenor,
        "purpose": purpose,
        "status": status,
        "maritalStatus": maritalStatus,
        "residentialAddress": residentialAddress,
        "inResidenceSince": inResidenceSince,
        "noOfDependants": noOfDependants,
        "educationalStatus": educationalStatus,
        "employmentStatus": employmentStatus,
        // "employerName": employerName,
        // "monthlyIncome": monthlyIncome,
        // "employerState": employerState,
        // "employerStateLga": employerStateLga,
        // "industry": industry,
        // "sector": sector,
        // "employmentStartDate": employmentStartDate,
        // "workEmail": workEmail,
        // "guarantorFirstName": guarantorFirstName,
        // "guarantorLastName": guarantorLastName,
        // "guarantorRelationship": guarantorRelationship,
        // "guarantorEmail": guarantorEmail,
        // "guarantorPhoneNumber": guarantorPhoneNumber
      };
}
