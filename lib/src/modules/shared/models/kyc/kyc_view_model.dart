import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';

class KycViewModel {
  final bool isLoading;
  final List<KycDocInfo> kycInfo;
  final TextEditingController referenceController;
  final File? fileFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;
  final UploadModel? docModel;
  final KycDocInfo? selectedKycInfo;

  KycViewModel({
    required this.referenceController,
    this.isLoading = false,
    this.kycInfo = const [],
    this.fileFromDevice,
    this.fileName,
    this.documentName = '',
    this.documentPath = '',
    this.docModel,
    this.selectedKycInfo,
  });

  KycViewModel copyWith({
    bool? isLoading,
    List<KycDocInfo>? kycInfo,
    TextEditingController? referenceController,
    File? fileFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
    UploadModel? docModel,
    KycDocInfo? selectedKycInfo,
  }) {
    return KycViewModel(
      isLoading: isLoading ?? this.isLoading,
      kycInfo: kycInfo ?? this.kycInfo,
      referenceController: referenceController ?? this.referenceController,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
      docModel: docModel ?? this.docModel,
      selectedKycInfo: selectedKycInfo ?? this.selectedKycInfo,
    );
  }
}
