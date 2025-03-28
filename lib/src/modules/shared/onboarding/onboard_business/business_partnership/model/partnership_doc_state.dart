import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';

class PartnershipDocState extends Equatable {
  final BusinessFileStatus utilityBill;
  final BusinessFileStatus cacCert;
  final BusinessFileStatus cacApply;
  final BusinessFileStatus deed;
  final BusinessFileStatus resAccount;
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
  //
  final File? deedFile;
  final String? deedFileName;
  final String deedDocName;
  final String deedDocPath;
  //
  final File? resAccountFile;
  final String? resAccountFileName;
  final String resAccountDocName;
  final String resAccountDocPath;

  const PartnershipDocState({
    required this.utilityBill,
    required this.cacCert,
    required this.cacApply,
    required this.deed,
    required this.resAccount,
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
    //
    required this.deedFile,
    required this.deedFileName,
    required this.deedDocName,
    required this.deedDocPath,
    //
    required this.resAccountFile,
    required this.resAccountFileName,
    required this.resAccountDocName,
    required this.resAccountDocPath,
  });

  PartnershipDocState copyWith({
    BusinessFileStatus? utilityBill,
    BusinessFileStatus? cacCert,
    BusinessFileStatus? cacApply,
    BusinessFileStatus? deed,
    BusinessFileStatus? resAccount,
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
    //
    File? deedFile,
    String? deedFileName,
    String? deedDocName,
    String? deedDocPath,
    //
    File? resAccountFile,
    String? resAccountFileName,
    String? resAccountDocName,
    String? resAccountDocPath,
  }) {
    return PartnershipDocState(
      utilityBill: utilityBill ?? this.utilityBill,
      cacCert: cacCert ?? this.cacCert,
      cacApply: cacApply ?? this.cacApply,
      deed: deed ?? this.deed,
      resAccount: resAccount ?? this.deed,
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
      deedFile: deedFile ?? this.deedFile,
      deedFileName: deedFileName ?? this.deedFileName,
      deedDocName: deedDocName ?? this.deedDocName,
      deedDocPath: deedDocPath ?? this.deedDocPath,
      resAccountFile: resAccountFile ?? this.resAccountFile,
      resAccountFileName: resAccountFileName ?? this.resAccountFileName,
      resAccountDocName: resAccountDocName ?? this.resAccountDocName,
      resAccountDocPath: resAccountDocPath ?? this.resAccountDocPath,
    );
  }

  @override
  List<Object?> get props => [
        utilityBill,
        cacCert,
        cacApply,
        deed,
        resAccount,
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
        //
        deedFile,
        deedFileName,
        deedDocName,
        deedDocPath,
        //
        resAccountFile,
        resAccountFileName,
        resAccountDocName,
        resAccountDocPath,
      ];
}
