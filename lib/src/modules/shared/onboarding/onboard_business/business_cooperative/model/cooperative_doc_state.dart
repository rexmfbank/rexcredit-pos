import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';

class CooperativeDocState extends Equatable {
  final BusinessFileStatus utilityBill;
  final BusinessFileStatus registerCert;
  final BusinessFileStatus resAccount;
  final BusinessFileStatus constitution;
  final List<CustomerDocumentDto> businessDocs;
  //
  final File? utilityBillFile;
  final String? utilityBillFileName;
  final String utilityBillDocName;
  final String utilityBillDocPath;
  //
  final File? registerCertFile;
  final String? registerCertFileName;
  final String registerCertDocName;
  final String registerCertDocPath;
  //
  final File? resAccountFile;
  final String? resAccountFileName;
  final String resAccountDocName;
  final String resAccountDocPath;
  //
  final File? constitutionFile;
  final String? constitutionFileName;
  final String constitutionDocName;
  final String constitutionDocPath;

  const CooperativeDocState({
    required this.utilityBill,
    required this.registerCert,
    required this.resAccount,
    required this.constitution,
    required this.businessDocs,
    //
    required this.utilityBillFile,
    required this.utilityBillFileName,
    required this.utilityBillDocName,
    required this.utilityBillDocPath,
    //
    required this.registerCertFile,
    required this.registerCertFileName,
    required this.registerCertDocName,
    required this.registerCertDocPath,
    //
    required this.resAccountFile,
    required this.resAccountFileName,
    required this.resAccountDocName,
    required this.resAccountDocPath,
    //
    required this.constitutionFile,
    required this.constitutionFileName,
    required this.constitutionDocName,
    required this.constitutionDocPath,
  });

  CooperativeDocState copyWith({
    BusinessFileStatus? utilityBill,
    BusinessFileStatus? registerCert,
    BusinessFileStatus? resAccount,
    BusinessFileStatus? constitution,
    List<CustomerDocumentDto>? businessDocs,
    //
    File? utilityBillFile,
    String? utilityBillFileName,
    String? utilityBillDocName,
    String? utilityBillDocPath,
    //
    File? registerCertFile,
    String? registerCertFileName,
    String? registerCertDocName,
    String? registerCertDocPath,
    //
    File? resAccountFile,
    String? resAccountFileName,
    String? resAccountDocName,
    String? resAccountDocPath,
    //
    File? constitutionFile,
    String? constitutionFileName,
    String? constitutionDocName,
    String? constitutionDocPath,
  }) {
    return CooperativeDocState(
      utilityBill: utilityBill ?? this.utilityBill,
      registerCert: registerCert ?? this.registerCert,
      resAccount: resAccount ?? this.resAccount,
      constitution: constitution ?? this.constitution,
      businessDocs: businessDocs ?? this.businessDocs,
      utilityBillFile: utilityBillFile ?? this.utilityBillFile,
      utilityBillFileName: utilityBillFileName ?? this.utilityBillFileName,
      utilityBillDocName: utilityBillDocName ?? this.utilityBillDocName,
      utilityBillDocPath: utilityBillDocPath ?? this.utilityBillDocPath,
      registerCertFile: registerCertFile ?? this.registerCertFile,
      registerCertFileName: registerCertFileName ?? this.registerCertFileName,
      registerCertDocName: registerCertDocName ?? this.registerCertDocName,
      registerCertDocPath: registerCertDocPath ?? this.registerCertDocPath,
      resAccountFile: resAccountFile ?? this.resAccountFile,
      resAccountFileName: resAccountFileName ?? this.resAccountFileName,
      resAccountDocName: resAccountDocName ?? this.resAccountDocName,
      resAccountDocPath: resAccountDocPath ?? this.resAccountDocPath,
      constitutionFile: constitutionFile ?? this.constitutionFile,
      constitutionFileName: constitutionFileName ?? this.constitutionFileName,
      constitutionDocName: constitutionDocName ?? this.constitutionDocName,
      constitutionDocPath: constitutionDocPath ?? this.constitutionDocPath,
    );
  }

  @override
  List<Object?> get props => [
        utilityBill,
        registerCert,
        resAccount,
        constitution,
        businessDocs,
        //
        utilityBillFile,
        utilityBillFileName,
        utilityBillDocName,
        utilityBillDocPath,
        //
        registerCertFile,
        registerCertFileName,
        registerCertDocName,
        registerCertDocPath,
        //
        resAccountFile,
        resAccountFileName,
        resAccountDocName,
        resAccountDocPath,
        //
        constitutionFile,
        constitutionFileName,
        constitutionDocName,
        constitutionDocPath,
      ];
}
