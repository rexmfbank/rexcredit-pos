import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/printer_json.dart';
import 'package:rex_app/src/modules/individual/purchase/model/printer_json2.dart';

const platform = MethodChannel('com.rexmfb.mobile');

Future<String?> startIntentAndGetResult({
  required String packageName,
  required String extraData,
}) async {
  try {
    final result = await platform.invokeMethod<String>(
      'startIntent',
      {
        'packageName': packageName,
        'extraData': extraData,
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
  required String extraData,
}) async {
  try {
    final result = await platform.invokeMethod<String>(
      'startIntentPrinter',
      {
        'packageName': packageName,
        'extraData': extraData,
      },
    );
    return result;
  } on PlatformException catch (e) {
    debugPrint('Error: ${e.message}');
    return null;
  }
}

void sendToKeyExchange() async {
  await startIntentAndGetResult(
    packageName: "com.globalaccelerex.keyexchange",
    extraData: "",
  );
}

void sendToPrintCardTransaction(BaseAppTransactionResponse response) async {
  final data = getJsonForPrintingCardTransaction(response);
  await startIntentPrinterAndGetResult(
    packageName: "com.globalaccelerex.printer",
    extraData: jsonEncode(data),
  );
}

void sendToPrintTestReceipt() async {
  final data = getJsonForTestingPrinter();
  await startIntentPrinterAndGetResult(
    packageName: "com.globalaccelerex.printer",
    extraData: jsonEncode(data),
  );
}

void sendToPrintTransferDetail(TransferData value) async {
  final data = getJsonForPrintingTransactionDetail(value);
  await startIntentPrinterAndGetResult(
    packageName: "com.globalaccelerex.printer",
    extraData: jsonEncode(data),
  );
}
