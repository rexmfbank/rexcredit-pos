
class LoanApplicationGuarantorRequest {
  final String section;
  final String loanRefNo;
  final String guarantorFirstName;
  final String guarantorLastName;
  final String guarantorRelationship;
  final String? guarantorEmail;
  final String? guarantorPhoneNumber;

  LoanApplicationGuarantorRequest({
    required this.section,
    required this.loanRefNo,
    required this.guarantorFirstName,
    required this.guarantorLastName,
    required this.guarantorRelationship,
    this.guarantorEmail,
    this.guarantorPhoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "section": section,
    "loanRefNo": loanRefNo,
    "guarantorFirstName": guarantorFirstName,
    "guarantorLastName": guarantorLastName,
    "guarantorRelationship": guarantorRelationship,
    "guarantorEmail": guarantorEmail,
    "guarantorPhoneNumber": guarantorPhoneNumber
  };

}