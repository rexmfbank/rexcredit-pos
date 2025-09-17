// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/model/receipt_view_model.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/transaction_codes.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

final receiptNotifier = NotifierProvider<ReceiptNotifier, ReceiptViewModel>(
  () => ReceiptNotifier(),
);

class ReceiptNotifier extends Notifier<ReceiptViewModel> {
  @override
  ReceiptViewModel build() => ReceiptViewModel(
    globalKey: GlobalKey(),
    screenshotController: ScreenshotController(),
  );

  Future<Uint8List?> captureImage() async {
    try {
      RenderRepaintBoundary boundary =
          state.globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 8.0);
      ByteData byteData =
          await image.toByteData(format: ImageByteFormat.png) as ByteData;
      Uint8List unit8List = byteData.buffer.asUint8List();
      return unit8List;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<File> convertUint8ListToFile(Uint8List data, String filename) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(data);
    return file;
  }

  /*Future<void> shareImage() async {
    Uint8List? imageBytes = await captureImage();
    if (imageBytes != null && imageBytes.isNotEmpty) {
      final timeNow = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '_')
          .replaceAll(':', '_');
      final fileName = 'Receipt_$timeNow';
      final file = XFile.fromData(
        imageBytes,
        name: '$fileName.png',
        mimeType: 'image/png',
      );
      await Share.shareXFiles(
        [file],
        subject: StringAssets.receiptImage,
      );
    }
  }*/

  Future<void> shareImage(BuildContext context) async {
    Uint8List? imageBytes;
    await state.screenshotController
        .capture(delay: const Duration(milliseconds: 100))
        .then((value) => imageBytes = value);
    final box = context.findRenderObject() as RenderBox?;
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      final timeNow = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '_')
          .replaceAll(':', '_');
      final fileName = 'Receipt_$timeNow';
      final file = XFile.fromData(
        imageBytes!,
        name: '$fileName.png',
        mimeType: 'image/png',
      );

      if (Platform.isAndroid) {
        await Share.shareXFiles([file], subject: StringAssets.receiptImage);
      } else if (Platform.isIOS) {
        await Share.shareXFiles(
          [file],
          subject: StringAssets.receiptImage,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      }
    }
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      final device = await DeviceInfoPlugin().androidInfo;
      if (Platform.isAndroid && device.version.sdkInt > 29) {
        final request = await Permission.manageExternalStorage.request();
        return request.isGranted;
      } else {
        final request = await Permission.storage.request();
        return request.isGranted;
      }
    }

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        showModalActionError(
          context: context,
          title: StringAssets.storageDeniedError,
          errorText: StringAssets.storageDeniedDirections,
          onTap: () => openAppSettings(),
        );
      }
      return Permission.storage.status.isGranted;
    }

    return true;
  }

  /*Future<String> saveImageToDeviceGallery({
    required Uint8List imageBytes,
    required BuildContext context,
  }) async {
    //  bool permission = await requestStoragePermission(context);
    // if(!permission){
    //   context.showToast(message: 'ERROR');
    //   return '';
    // }
    final timeNow = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final fileName = 'Receipt_$timeNow';
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(imageBytes),
        name: fileName);
    print(result);
    if (result['isSuccess']) {
      debugPrint('Image saved to gallery: ${result['filePath']}');
      if (context.mounted) {
        context.showToast(
          backgroundColor: AppColors.rexPurpleLight,
          message: '${StringAssets.imageSaved}: ${result['filePath']}',
        );
      }
      return result['filepath'];
    } else {
      debugPrint('Failed to save image: ${result['error']}');
      if (context.mounted) {
        context.showToast(
          backgroundColor: AppColors.rexPurpleLight,
          message: StringAssets.failedToSaveImage,
        );
      }
      return '';
    }
  }*/

  Future<void> downloadImage({
    required Uint8List imageBytes,
    required String transactionType,
    required BuildContext context,
  }) async {
    final permission = await requestStoragePermission(context);
    if (!permission) {
      return;
    }
    await getExternalStorageDirectory();
    //  print(directory!.path);
    final timeNow = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    var mime = lookupMimeType('', headerBytes: imageBytes);
    extensionFromMime(mime ?? '');

    final fileName =
        'Receipt_${transactionType.transactionCodes!.jsonString}_$timeNow.png';
    //  final File imageFile = File('${directory.path}/$fileName');
    final File imageFile = await File('/storage/emulated/0/$fileName').create();
    try {
      imageFile.writeAsBytes(imageBytes);
      if (context.mounted) {
        context.showToast(
          backgroundColor: AppColors.rexPurpleLight,
          message: StringAssets.imageSavedSuccessfully,
        );
      }
    } catch (e) {
      if (context.mounted) {
        context.showToast(
          backgroundColor: AppColors.rexPurpleLight,
          message: StringAssets.failedToSaveImage,
        );
      }
    }
  }
}
