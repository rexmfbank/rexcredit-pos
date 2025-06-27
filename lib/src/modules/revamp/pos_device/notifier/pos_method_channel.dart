import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const platform = MethodChannel('com.rexmfb.mobile');

Future<String?> startIntentAndGetResult({
  required String packageName,
  required String dataKey,
  required String dataValue,
}) async {
  debugPrint("startIntentAndGetResult HAS BEEN CALLED");
  try {
    final result = await platform.invokeMethod<String>(
      'startIntent',
      {
        'packageName': packageName,
        dataKey: dataValue,
      },
    );
    debugPrint("RESULT FROM KEY EXCHANGE");
    debugPrint(result);
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

Future<String?> saveImageToPublicStorage() async {
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    debugPrint('Storage permission not granted.');
    return null;
  }

  final Directory? publicDirectory = await getExternalStorageDirectory();
  if (publicDirectory == null) {
    debugPrint('Could not get external storage directory.');
    return null;
  }

  final String publicPicturesPath = '${publicDirectory.path}/Pictures';
  final Directory customPublicDirectory = Directory(publicPicturesPath);
  if (!await customPublicDirectory.exists()) {
    await customPublicDirectory.create(recursive: true);
  }

  final String filePath = '${customPublicDirectory.path}/rex_logo_print.png';
  final File file = File(filePath);
  if (await file.exists()) {
    debugPrint('Image already exists at: $filePath');
    return filePath;
  }

  try {
    final byteData = await rootBundle.load('assets/png/rex_logo_2.png');
    final buffer = byteData.buffer.asUint8List();
    await file.writeAsBytes(buffer);
    debugPrint('Image saved to: $filePath');
    return filePath;
  } catch (e) {
    debugPrint('Error saving image to public storage: $e');
    return null;
  }
}
