import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/kyc/upload_document_modal.dart';
import 'package:rex_app/src/modules/shared/models/file_upload/file_upload_model.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/file_utils.dart';

final fileUploadNotifier =
    AutoDisposeNotifierProvider<FileUploadNotifier, FileUploadModel>(
        () => FileUploadNotifier());

class FileUploadNotifier extends AutoDisposeNotifier<FileUploadModel> {
  @override
  FileUploadModel build() => const FileUploadModel();

  void toggleIsLoading(bool value) => state = state.copyWith(isLoading: value);

  void showOptionModal({
    required BuildContext context,
    List<String>? allowedExtensions,
    VoidCallback? onSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.rexWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.ar),
          topRight: Radius.circular(30.ar),
        ),
      ),
      builder: (context) {
        return UploadDocumentModal(
          onCameraClicked: () {
            context.pop();
            takePicture(
              context: context,
              onSuccess: () => onSuccess?.call(),
            );
          },
          onDocumentClicked: () {
            context.pop();
            getFileFromDevice(
              context: context,
              allowedExtensions: allowedExtensions,
              onSuccess: () => onSuccess?.call(),
            );
          },
        );
      },
    );
  }

  Future<void> getFileFromDevice({
    required BuildContext context,
    List<String>? allowedExtensions,
    VoidCallback? onSuccess,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: allowedExtensions!= null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      state = state.copyWith(
        fileFromDevice: file,
        fileName: File(file.path).uri.pathSegments.last,
      );
      onSuccess?.call();
      return;
    }
    if (context.mounted) {
      context.showToast(message: StringAssets.somethingWentWrongFile);
    }
  }

  Future<void> takePicture(
      {required BuildContext context, VoidCallback? onSuccess}) async {
    var xFile = await FileUtils.pickImage(source: StringAssets.camera);
    if (xFile != null) {
      File file = File(xFile.path);
      state = state.copyWith(
        fileFromDevice: file,
        fileName: File(file.path).uri.pathSegments.last,
      );
      onSuccess?.call();
      return;
    }
    if (context.mounted) {
      context.showToast(message: StringAssets.somethingWentWrongFile);
    }
  }

  UploadModel returnFileDetails() => UploadModel(
        fileFromDevice: state.fileFromDevice!,
        fileName: state.fileName!,
      );
}
