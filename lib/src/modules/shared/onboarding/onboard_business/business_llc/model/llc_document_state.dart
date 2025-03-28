// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';

class LLC_DocumentState extends Equatable {
  final BusinessFileStatus utilityBill;
  final BusinessFileStatus cacCert;
  final BusinessFileStatus memorandum;
  final BusinessFileStatus formCo7;
  final BusinessFileStatus formCo2;
  final BusinessFileStatus resBoard;
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
  final File? memorandumFile;
  final String? memorandumFileName;
  final String memorandumDocName;
  final String memorandumDocPath;
  //
  final File? formCo7File;
  final String? formCo7FileName;
  final String formCo7DocName;
  final String formCo7DocPath;
  //
  final File? formCo2File;
  final String? formCo2FileName;
  final String formCo2DocName;
  final String formCo2DocPath;
  //
  final File? resBoardFile;
  final String? resBoardFileName;
  final String resBoardDocName;
  final String resBoardDocPath;

  const LLC_DocumentState({
    required this.utilityBill,
    required this.cacCert,
    required this.memorandum,
    required this.formCo7,
    required this.formCo2,
    required this.resBoard,
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
    required this.memorandumFile,
    required this.memorandumFileName,
    required this.memorandumDocName,
    required this.memorandumDocPath,
    //
    required this.formCo7File,
    required this.formCo7FileName,
    required this.formCo7DocName,
    required this.formCo7DocPath,
    //
    required this.formCo2File,
    required this.formCo2FileName,
    required this.formCo2DocName,
    required this.formCo2DocPath,
    //
    required this.resBoardFile,
    required this.resBoardFileName,
    required this.resBoardDocName,
    required this.resBoardDocPath,
  });

  LLC_DocumentState copyWith({
    BusinessFileStatus? utilityBill,
    BusinessFileStatus? cacCert,
    BusinessFileStatus? memorandum,
    BusinessFileStatus? formCo7,
    BusinessFileStatus? formCo2,
    BusinessFileStatus? resBoard,
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
    File? memorandumFile,
    String? memorandumFileName,
    String? memorandumDocName,
    String? memorandumDocPath,
    //
    File? formCo7File,
    String? formCo7FileName,
    String? formCo7DocName,
    String? formCo7DocPath,
    //
    File? formCo2File,
    String? formCo2FileName,
    String? formCo2DocName,
    String? formCo2DocPath,
    //
    File? resBoardFile,
    String? resBoardFileName,
    String? resBoardDocName,
    String? resBoardDocPath,
  }) {
    return LLC_DocumentState(
      utilityBill: utilityBill ?? this.utilityBill,
      cacCert: cacCert ?? this.cacCert,
      memorandum: memorandum ?? this.memorandum,
      formCo7: formCo7 ?? this.formCo7,
      formCo2: formCo2 ?? this.formCo2,
      resBoard: resBoard ?? this.resBoard,
      businessDocs: businessDocs ?? this.businessDocs,
      utilityBillFile: utilityBillFile ?? this.utilityBillFile,
      utilityBillFileName: utilityBillFileName ?? this.utilityBillFileName,
      utilityBillDocName: utilityBillDocName ?? this.utilityBillDocName,
      utilityBillDocPath: utilityBillDocPath ?? this.utilityBillDocPath,
      cacCertFile: cacCertFile ?? this.cacCertFile,
      cacCertFileName: cacCertFileName ?? this.cacCertFileName,
      cacCertDocName: cacCertDocName ?? this.cacCertDocName,
      cacCertDocPath: cacCertDocPath ?? this.cacCertDocPath,
      memorandumFile: memorandumFile ?? this.memorandumFile,
      memorandumFileName: memorandumFileName ?? this.memorandumFileName,
      memorandumDocName: memorandumDocName ?? this.memorandumDocName,
      memorandumDocPath: memorandumDocPath ?? this.memorandumDocPath,
      formCo7File: formCo7File ?? this.formCo7File,
      formCo7FileName: formCo7FileName ?? this.formCo2FileName,
      formCo7DocName: formCo7DocName ?? this.formCo7DocName,
      formCo7DocPath: formCo7DocPath ?? this.formCo7DocPath,
      formCo2File: formCo2File ?? this.formCo2File,
      formCo2FileName: formCo2FileName ?? this.formCo2FileName,
      formCo2DocName: formCo2DocName ?? this.formCo2DocName,
      formCo2DocPath: formCo2DocPath ?? this.formCo2DocPath,
      resBoardFile: resBoardFile ?? this.resBoardFile,
      resBoardFileName: resBoardFileName ?? this.resBoardFileName,
      resBoardDocName: resBoardDocName ?? this.resBoardDocName,
      resBoardDocPath: resBoardDocPath ?? this.resBoardDocPath,
    );
  }

  @override
  List<Object?> get props => [
        utilityBill,
        cacCert,
        memorandum,
        formCo7,
        formCo2,
        resBoard,
        businessDocs,
        utilityBillFile,
        utilityBillFileName,
        utilityBillDocName,
        utilityBillDocPath,
        cacCertFile,
        cacCertFileName,
        cacCertDocName,
        cacCertDocPath,
        memorandumFile,
        memorandumFileName,
        memorandumDocName,
        memorandumDocPath,
        formCo7File,
        formCo7FileName,
        formCo7DocName,
        formCo7DocPath,
        formCo2File,
        formCo2FileName,
        formCo2DocName,
        formCo2DocPath,
        resBoardFile,
        resBoardFileName,
        resBoardDocName,
        resBoardDocPath,
      ];
}
