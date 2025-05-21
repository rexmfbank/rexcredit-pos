import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/shared/pos_device/printer_json.dart';

const platform = MethodChannel('com.rexmfb.mobile');

Future<String?> startIntentAndGetResult({
  required String packageName,
  required String dataKey,
  required String dataValue,
}) async {
  try {
    final result = await platform.invokeMethod<String>(
      'startIntent',
      {
        'packageName': packageName,
        dataKey: dataValue,
      },
    );
    return result;
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
    return null;
  }
}

Future<String?> startIntentK11AndGetResult({
  required String packageName,
  required String dataKey,
  required String dataValue,
}) async {
  try {
    final result = await platform.invokeMethod<String>(
      'startIntentK11',
      {
        'packageName': packageName,
        dataKey: dataValue,
      },
    );
    return result;
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
    return null;
  }
}

Future<String?> startIntentPrinterAndGetResult({
  required String packageName,
  required String dataKey,
  required String dataValue,
}) async {
  try {
    final result = await platform.invokeMethod<String>(
      'startIntentPrinter',
      {
        'packageName': packageName,
        dataKey: dataValue,
      },
    );
    return result;
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
    return null;
  }
}

/*Future<String?> saveAssetImageToGallery({
  required String assetPath,
  required String imageName,
}) async {
  final ByteData data = await rootBundle.load(assetPath);
  final Uint8List bytes = data.buffer.asUint8List();
  //const platform = MethodChannel('image.saver/channel');

  try {
    final String? savedPath =
        await platform.invokeMethod('saveImageToGallery', {
      'imageBytes': bytes,
      'name': imageName,
      'mimeType': 'image/png',
      'relativePath': 'Pictures/MyAppImages', // Optional folder name
    });
    debugPrint("Saved image at: $savedPath");
    return savedPath;
  } on PlatformException catch (e) {
    debugPrint("Error saving image: ${e.message}");
    return null;
  }
}*/

Future<String?> saveImageToStorage() async {
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    return null;
  }

  final directory = await getExternalStorageDirectory();
  if (directory == null) return null;

  final filePath = '${directory.path}/rex_logo_print.png';
  final file = File(filePath);
  if (await file.exists()) {
    return filePath;
  }

  final byteData = await rootBundle.load('assets/png/rex_logo_2.png');
  final buffer = byteData.buffer.asUint8List();
  await file.writeAsBytes(buffer);
  return filePath;
}

void sendToPrintCardTransaction(
  BaseAppTransactionResponse response,
  String filePath,
) async {
  final data = getJsonForPrintingCardTransaction(response, filePath);
  await startIntentPrinterAndGetResult(
    packageName: "com.globalaccelerex.printer",
    dataKey: "extraData",
    dataValue: jsonEncode(data),
  );
}
