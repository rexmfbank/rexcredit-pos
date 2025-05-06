import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/model/face_detection_state.dart';

final faceDetectionProvider =
    NotifierProvider<FaceDetectionNotifier, FaceDetectionState>(
  () => FaceDetectionNotifier(),
);

class FaceDetectionNotifier extends Notifier<FaceDetectionState> {
  @override
  FaceDetectionState build() {
    return const FaceDetectionState(
      imageFromDevice: null,
      fileName: null,
      documentName: '',
      documentPath: '',
      capturedImage: FaceCapturedImage.imageIsNull,
      continueRegistration: false,
    );
  }

  void disableButton() {
    switch (state.capturedImage) {
      case FaceCapturedImage.imageIsNull:
        () => state = state.copyWith(isDisabled: false);
        return;

      case FaceCapturedImage.imageIsNotNull:
        () => state = state.copyWith(isDisabled: true);
        return;

      case FaceCapturedImage.imageIsUploading:
        () => state = state.copyWith(isDisabled: true);
        return;

      case FaceCapturedImage.imageIsUploaded:
        () => state = state.copyWith(isDisabled: false);
        return;

      case FaceCapturedImage.imageUploadError:
        () => state = state.copyWith(isDisabled: false);
        return;
    }
  }

  void setImage(String? captureImagePath) {
    if (captureImagePath == null) return;
    final file = File(captureImagePath);
    final fileName = File(captureImagePath).uri.pathSegments.last;
    state = state.copyWith(imageFromDevice: file, fileName: fileName);
    uploadFileToServer();
  }

  Future<void> uploadFileToServer() async {
    state = state.copyWith(capturedImage: FaceCapturedImage.imageIsNotNull);
    try {
      state = state.copyWith(capturedImage: FaceCapturedImage.imageIsUploading);
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.imageFromDevice?.path ?? '',
        fileName: state.fileName ?? '',
      );
      state = state.copyWith(
        capturedImage: FaceCapturedImage.imageIsUploaded,
        documentName: uploadResponse.data?.id,
        documentPath: uploadResponse.data?.refNo,
        continueRegistration: true,
      );
    } catch (error) {
      state = state.copyWith(
        capturedImage: FaceCapturedImage.imageUploadError,
        imageFromDevice: null,
        documentName: '',
        documentPath: '',
        continueRegistration: false,
      );
    }
  }
}
