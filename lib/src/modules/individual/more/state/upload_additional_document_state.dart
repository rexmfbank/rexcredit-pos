import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';

class UploadAdditionalDocumentState {
  final TextEditingController documentIdNoController;
  final File? fileFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;
  final UploadModel? docModel;
  final SaveKycDocsResponse? savedDocData;
  final bool isLoading;
  final String? error;
  final bool? imagesPickedHaveDownloadUrl;

  const UploadAdditionalDocumentState({
    required this.documentIdNoController,
    this.fileFromDevice,
    this.fileName,
    this.documentName = '',
    this.documentPath = '',
    this.docModel,
    this.savedDocData,
    required this.isLoading,
    this.error,
    this.imagesPickedHaveDownloadUrl,
  });

  UploadAdditionalDocumentState copyWith({
    TextEditingController? documentIdNoController,
    File? fileFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
    UploadModel? docModel,
    SaveKycDocsResponse? savedDocData,
    bool? isLoading,
    String? error,
    bool? imagesPickedHaveDownloadUrl,
  }) {
    return UploadAdditionalDocumentState(
      documentIdNoController:
          documentIdNoController ?? this.documentIdNoController,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
      docModel: docModel ?? this.docModel,
      savedDocData: savedDocData ?? this.savedDocData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imagesPickedHaveDownloadUrl:
          imagesPickedHaveDownloadUrl ?? this.imagesPickedHaveDownloadUrl,
    );
  }

  factory UploadAdditionalDocumentState.initial() {
    return UploadAdditionalDocumentState(
      documentIdNoController: TextEditingController(),
      isLoading: false,
      imagesPickedHaveDownloadUrl: false,
    );
  }
}
