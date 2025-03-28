import 'dart:io';
import 'package:equatable/equatable.dart';

enum FaceCapturedImage {
  imageIsNull,
  imageIsNotNull,
  imageIsUploading,
  imageIsUploaded,
  imageUploadError,
}

class FaceDetectionState extends Equatable {
  final File? imageFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;
  final FaceCapturedImage capturedImage;
  final bool continueRegistration;
  final bool isDisabled;

  const FaceDetectionState({
    required this.imageFromDevice,
    required this.fileName,
    required this.documentName,
    required this.documentPath,
    required this.capturedImage,
    required this.continueRegistration,
    this.isDisabled = false,
  });

  FaceDetectionState copyWith({
    File? imageFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
    FaceCapturedImage? capturedImage,
    bool? continueRegistration,
    bool? isDisabled,
  }) {
    return FaceDetectionState(
      isDisabled: isDisabled ?? this.isDisabled,
      imageFromDevice: imageFromDevice ?? this.imageFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
      capturedImage: capturedImage ?? this.capturedImage,
      continueRegistration: continueRegistration ?? this.continueRegistration,
    );
  }

  @override
  List<Object?> get props => [
        isDisabled,
        imageFromDevice,
        fileName,
        documentName,
        documentPath,
        capturedImage,
        continueRegistration,
      ];
}
