import 'package:equatable/equatable.dart';

// "data": [
    //     {
    //         "refNo": "LNA-lu-0499",
    //         "loanTitle": "INDIVIDUAL",
    //         "amountApplied": 11000.00,
    //         "amountApproved": null,
    //         "approvedBy": null,
    //         "tenor": 8,
    //         "purpose": "Education",
    //         "status": "ACCEPTED",
    //         "maritalStatus": "Single",
    //         "residentialAddress": "12, Marimar Drive",
    //         "inResidenceSince": "11-05-2015",
    //         "noOfDependants": 8,
    //         "educationalStatus": "Ph.D",
    //         "bankStatementStatus": null,
    //         "monoTokenId": null,
    //         "guarantorDetails": {
    //             "firstName": "Jay",
    //             "lastName": "Boy",
    //             "relationship": "Friend",
    //             "email": "anijay@gmail.com",
    //             "phoneNumber": "09043455745"
    //         },
    //         "employerDetails": null,
    //         "repayment": null,
    //         "createdAt": "18-12-2023",
    //         "username": "lukeshaw"
    //     },
    //     {
    //         "refNo": "LNA-lu-2876",
    //         "loanTitle": "INDIVIDUAL",
    //         "amountApplied": 25000.00,
    //         "amountApproved": null,
    //         "approvedBy": null,
    //         "tenor": 6,
    //         "purpose": "Education",
    //         "status": "INITIATED",
    //         "maritalStatus": "Single",
    //         "residentialAddress": "12, Marimar Drive",
    //         "inResidenceSince": "10-12-2023",
    //         "noOfDependants": 8,
    //         "educationalStatus": "Ph.D",
    //         "bankStatementStatus": null,
    //         "monoTokenId": null,
    //         "guarantorDetails": null,
    //         "employerDetails": null,
    //         "repayment": null,
    //         "createdAt": "18-12-2023",
    //         "username": "lukeshaw"
    //     },
    // ]

class GuarantorDetails extends Equatable {
  final String firstName;
  final String lastName;
  final String? relationship;
  final String? email;
  final String? phoneNumber;

  GuarantorDetails({
    required this.firstName,
    required this.lastName,
    this.relationship,
    this.email,
    this.phoneNumber,
  });

  GuarantorDetails.empty()
      : firstName = '',
        lastName = '',
        relationship = '',
        email = '',
        phoneNumber = '';

  factory GuarantorDetails.fromJson(Map<String, dynamic> json) => GuarantorDetails(
        firstName: json["firstName"],
        lastName: json["lastName"],
        relationship: json["relationship"],
        email: json["email"],
        phoneNumber: json["phoneNumber"]
      );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        relationship,
        email,
        phoneNumber
      ];
}
