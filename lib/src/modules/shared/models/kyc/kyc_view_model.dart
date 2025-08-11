import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';

class KycViewModel {
  final bool isLoading;
  final TextEditingController referenceController;
  final File? fileFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;
  final UploadModel? docModel;

  KycViewModel({
    required this.referenceController,
    this.isLoading = false,
    this.fileFromDevice,
    this.fileName,
    this.documentName = '',
    this.documentPath = '',
    this.docModel,
  });

  KycViewModel copyWith({
    bool? isLoading,
    TextEditingController? referenceController,
    File? fileFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
    UploadModel? docModel,
  }) {
    return KycViewModel(
      isLoading: isLoading ?? this.isLoading,
      referenceController: referenceController ?? this.referenceController,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
      docModel: docModel ?? this.docModel,
    );
  }
}
