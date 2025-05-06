import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';

class LoanApplicationResponseData extends Equatable {
  final String refNo;
  final String loanTitle;
  final double amountApplied;
  final double? amountApproved;
  final String? approvedBy;
  final int? tenor;
  final String? purpose;
  final String? status;
  final String? maritalStatus;
  final String? residentialAddress;
  final String? inResidenceSince;
  final int? noOfDependants;
  final String? educationalStatus;
  final String? bankStatementStatus;
  final int? monoTokenId;
  final String? offerPDFLink;
  final GuarantorDetails? guarantorDetails;
  final dynamic employerDetails;
  final RepaymentData? repayment;

  const LoanApplicationResponseData({
    required this.refNo,
    required this.loanTitle,
    required this.amountApplied,
    this.amountApproved,
    this.approvedBy,
    this.tenor,
    this.purpose,
    this.status,
    this.maritalStatus,
    this.residentialAddress,
    this.inResidenceSince,
    this.noOfDependants,
    this.educationalStatus,
    this.bankStatementStatus,
    this.monoTokenId,
    this.offerPDFLink,
    this.guarantorDetails,
    this.employerDetails,
    this.repayment,
  });

  LoanApplicationResponseData.empty()
      : refNo = '',
        loanTitle = '',
        amountApplied = 0.0,
        amountApproved = 0.0,
        approvedBy = '',
        tenor = 1,
        purpose = '',
        status = '',
        maritalStatus = '',
        residentialAddress = '',
        inResidenceSince = null,
        noOfDependants = null,
        educationalStatus = '',
        bankStatementStatus = '',
        monoTokenId = 0,
        offerPDFLink = '',
        guarantorDetails = GuarantorDetails.empty(),
        employerDetails = null,
        repayment = RepaymentData.empty();

  factory LoanApplicationResponseData.fromJson(Map<String, dynamic> json) =>
      LoanApplicationResponseData(
        refNo: json["refNo"],
        loanTitle: json["loanTitle"],
        amountApplied: json["amountApplied"],
        amountApproved: json["amountApproved"],
        approvedBy: json["approvedBy"],
        tenor: json['tenor'],
        purpose: json['purpose'],
        status: json['status'],
        maritalStatus: json['maritalStatus'],
        residentialAddress: json['residentialAddress'],
        inResidenceSince: json['inResidenceSince'],
        noOfDependants: json['noOfDependants'],
        educationalStatus: json['educationalStatus'],
        bankStatementStatus: json['bankStatementStatus'],
        offerPDFLink: json['offerPDFLink'],
        monoTokenId: json['monoTokenId'],
        guarantorDetails: json['guarantorDetails'] != null
            ? GuarantorDetails.fromJson(json['guarantorDetails'])
            : null,
        employerDetails: json['employerDetails'],
        repayment: json['repayment'] == null
            ? null
            : RepaymentData.fromJson(json['repayment']),
      );

  @override
  List<Object?> get props => [
        refNo,
        loanTitle,
        amountApplied,
        amountApproved,
        approvedBy,
        tenor,
        purpose,
        status,
        maritalStatus,
        residentialAddress,
        inResidenceSince,
        noOfDependants,
        educationalStatus,
        bankStatementStatus,
        offerPDFLink,
        monoTokenId,
        guarantorDetails,
        employerDetails,
        repayment
      ];
}
