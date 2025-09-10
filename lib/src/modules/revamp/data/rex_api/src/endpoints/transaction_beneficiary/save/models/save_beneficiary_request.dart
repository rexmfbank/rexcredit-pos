import 'package:equatable/equatable.dart';

class SaveBeneficiaryRequest extends Equatable {
  final String accountNo;
  final String username;
  final String beneficiaryAccount;
  final String? beneficiaryMobile;
  final String beneficiaryName;
  final String tranCode;
  final String? beneficiaryDetail;
  final String createdDate;
  final String? createdBy;
  final String? status;
  final String? finEntityCode;
  final String? finEntityName;
  final String? entityCode;

  const SaveBeneficiaryRequest({
    required this.accountNo,
    required this.username,
    required this.beneficiaryAccount,
    this.beneficiaryMobile,
    required this.beneficiaryName,
    this.tranCode = "IBFT",
    this.beneficiaryDetail,
    required this.createdDate,
    this.createdBy,
    this.status,
    this.finEntityCode,
    this.finEntityName,
    this.entityCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountNo': accountNo,
      'username': username,
      'beneficiaryAccount': beneficiaryAccount,
      'beneficiaryMobile': beneficiaryMobile,
      'beneficiaryName': beneficiaryName,
      'tranCode': tranCode,
      'beneficiaryDetail': beneficiaryDetail,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'status': status,
      'finEntityCode': finEntityCode,
      'finEntityName': finEntityName,
      'entityCode': entityCode,
    };
  }

  @override
  List<Object?> get props => [
    accountNo,
    username,
    beneficiaryAccount,
    beneficiaryMobile,
    beneficiaryName,
    tranCode,
    beneficiaryDetail,
    createdDate,
    createdBy,
    status,
    finEntityCode,
    finEntityName,
    entityCode,
  ];
}
