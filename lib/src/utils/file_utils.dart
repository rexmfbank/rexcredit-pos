import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../modules/revamp/utils/config/theme/app_colors.dart';

class FileUtils {
  static Future<XFile?> pickImage({required String source}) async {
    final ImagePicker picker = ImagePicker();

    if (source == 'Camera') {
      return await picker.pickImage(source: ImageSource.camera);
    } else {
      return await picker.pickImage(source: ImageSource.gallery);
    }
  }

  static Future<CroppedFile?> cropImage({required XFile image}) async {
    var croppedImage =
        await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
      AndroidUiSettings(
          toolbarColor: AppColors.rexPurpleLight,
          statusBarColor: AppColors.rexPurpleLight,
          toolbarWidgetColor: AppColors.rexWhite),
    ]);
    return croppedImage;
  }

  // static Future<void> pickAndCropImage({
  //   required BuildContext context,
  //   required String source,
  //   required Function(CustomFile) onSuccess,
  // }) async {
  //   var xFile = await pickImage(source: source);
  //   if (xFile != null) {
  //     var croppedFile = await cropImage(image: xFile);
  //     if (croppedFile != null) {
  //       final file = File(croppedFile.path);
  //       int fileSizeInBytes = await file.length();

  //       CustomFile customImageFile = CustomFile(
  //         filePath: croppedFile.path,
  //         fileName: xFile.name,
  //         fileSize: FileUtils.formatFileSize(fileSizeInBytes),
  //       );

  //       if (context.mounted) {
  //         onSuccess.call(customImageFile);
  //       }
  //     }
  //   }
  // }

  static Future<FilePickerResult?> pickFile({
    bool allowMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    return result;
  }

  static String formatFileSize(int fileSizeInBytes) {
    const int KB = 1024;
    const int MB = KB * 1024;
    const int GB = MB * 1024;

    if (fileSizeInBytes < KB) {
      return '$fileSizeInBytes B';
    } else if (fileSizeInBytes < MB) {
      final double fileSizeInKB = fileSizeInBytes / KB;
      return '${fileSizeInKB.toStringAsFixed(2)} KB';
    } else if (fileSizeInBytes < GB) {
      final double fileSizeInMB = fileSizeInBytes / MB;
      return '${fileSizeInMB.toStringAsFixed(2)} MB';
    } else {
      final double fileSizeInGB = fileSizeInBytes / GB;
      return '${fileSizeInGB.toStringAsFixed(2)} GB';
    }
  }
}
