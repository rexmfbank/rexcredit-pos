import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';

class ProprietorDocState extends Equatable {
  final BusinessFileStatus utilityBill;
  final BusinessFileStatus cacCert;
  final BusinessFileStatus cacApply;
  final List<CustomerDocumentDto> businessDocs;
  //
  final File? utilityBillFile;
  final String? utilityBillFileName;
  final String utilityBillDocName;
  final String utilityBillDocPath;
  //
  final File? cacCertFile;
  final String? cacCertFileName;
  final String cacCertDocName;
  final String cacCertDocPath;
  //
  final File? cacApplyFile;
  final String? cacApplyFileName;
  final String cacApplyDocName;
  final String cacApplyDocPath;

  const ProprietorDocState({
    required this.utilityBill,
    required this.cacCert,
    required this.cacApply,
    required this.businessDocs,
    //
    required this.utilityBillFile,
    required this.utilityBillFileName,
    required this.utilityBillDocName,
    required this.utilityBillDocPath,
    //
    required this.cacCertFile,
    required this.cacCertFileName,
    required this.cacCertDocName,
    required this.cacCertDocPath,
    //
    required this.cacApplyFile,
    required this.cacApplyFileName,
    required this.cacApplyDocName,
    required this.cacApplyDocPath,
  });

  ProprietorDocState copyWith({
    BusinessFileStatus? utilityBill,
    BusinessFileStatus? cacCert,
    BusinessFileStatus? cacApply,
    List<CustomerDocumentDto>? businessDocs,
    //
    File? utilityBillFile,
    String? utilityBillFileName,
    String? utilityBillDocName,
    String? utilityBillDocPath,
    //
    File? cacCertFile,
    String? cacCertFileName,
    String? cacCertDocName,
    String? cacCertDocPath,
    //
    File? cacApplyFile,
    String? cacApplyFileName,
    String? cacApplyDocName,
    String? cacApplyDocPath,
  }) {
    return ProprietorDocState(
      utilityBill: utilityBill ?? this.utilityBill,
      cacCert: cacCert ?? this.cacCert,
      cacApply: cacApply ?? this.cacApply,
      businessDocs: businessDocs ?? this.businessDocs,
      utilityBillFile: utilityBillFile ?? this.utilityBillFile,
      utilityBillFileName: utilityBillFileName ?? this.utilityBillFileName,
      utilityBillDocName: utilityBillDocName ?? this.utilityBillDocName,
      utilityBillDocPath: utilityBillDocPath ?? this.utilityBillDocPath,
      cacCertFile: cacCertFile ?? this.cacCertFile,
      cacCertFileName: cacCertFileName ?? this.cacCertFileName,
      cacCertDocName: cacCertDocName ?? this.cacCertDocName,
      cacCertDocPath: cacCertDocPath ?? this.cacCertDocPath,
      cacApplyFile: cacApplyFile ?? this.cacApplyFile,
      cacApplyFileName: cacApplyFileName ?? this.cacApplyFileName,
      cacApplyDocName: cacApplyDocName ?? this.cacApplyDocName,
      cacApplyDocPath: cacApplyDocPath ?? this.cacApplyDocPath,
    );
  }

  @override
  List<Object?> get props => [
        utilityBill,
        cacCert,
        cacApply,
        businessDocs,
        //
        utilityBillFile,
        utilityBillFileName,
        utilityBillDocName,
        utilityBillDocPath,
        //
        cacCertFile,
        cacCertFileName,
        cacCertDocName,
        cacCertDocPath,
        //
        cacApplyFile,
        cacApplyFileName,
        cacApplyDocName,
        cacApplyDocPath,
      ];
}
