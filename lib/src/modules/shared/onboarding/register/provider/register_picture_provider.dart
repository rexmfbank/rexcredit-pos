import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/model/register_picture_state.dart';

final registerPictureProvider =
    NotifierProvider<RegisterPictureNotifier, RegisterPictureState>(
  () => RegisterPictureNotifier(),
);

class RegisterPictureNotifier extends Notifier<RegisterPictureState> {
  @override
  RegisterPictureState build() {
    return const RegisterPictureState(
      imageFromDevice: null,
      documentName: '',
      documentPath: '',
      errorUploading: false,
    );
  }

  Future<void> getImageFromCamera() async {
    state = state.copyWith(errorUploading: false);
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
    );
    if (image == null) return;
    final imageFile = File(image.path);
    final imageFileName = File(imageFile.path).uri.pathSegments.last;
    state = state.copyWith(imageFromDevice: imageFile, fileName: imageFileName);
    uploadFileToServer();
    getFileSize();
  }

  Future<void> uploadFileToServer() async {
    try {
      final uploadResponse = await RexApi.instance.uploadFile(
        filePath: state.imageFromDevice?.path ?? '',
        fileName: state.fileName ?? '',
      );
      state = state.copyWith(
        documentName: uploadResponse.data?.id,
        documentPath: uploadResponse.data?.refNo,
        errorUploading: false,
      );
    } catch (error) {
      state = state.copyWith(
        documentName: '',
        documentPath: '',
        errorUploading: true,
        imageFromDevice: null,
      );
    }
  }

  Future<void> getFileSize() async {
    final fileBytes = await File(state.imageFromDevice!.path).readAsBytes();
    final len = fileBytes.lengthInBytes;
    final fileSizeInKB = len / 1000;
    debugPrint('>>>>>>IMAGE IN KB $fileSizeInKB');
    final fileSizeInMB = fileSizeInKB / 1000;
    debugPrint('>>>>>>IMAGE IN MB $fileSizeInMB');
  }
}
