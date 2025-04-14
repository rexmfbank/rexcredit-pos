import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_utility_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/printer_json.dart';

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
    print('Error: ${e.message}');
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
    print('Error: ${e.message}');
    return null;
  }
}

void sendToKeyExchange() async {
  await startIntentAndGetResult(
    packageName: "com.globalaccelerex.keyexchange",
    extraData: "",
  );
}

void sendToUtility() async {
  const jsonString =
      '{ "transType": "PURCHASE", "amount": "2.00", "print": "false" }';
  final result = await startIntentAndGetResult(
    packageName: "com.globalaccelerex.utility",
    extraData: jsonString,
  );
  IntentUtilityResponse response =
      IntentUtilityResponse.fromJson(jsonDecode(result ?? ""));
  print("Utility Response: $result");
}

void makeCardTransaction() async {
  const jsonString =
      '{ "transType": "PURCHASE", "amount": "10.00", "print": "false" }';
  final result = await startIntentAndGetResult(
    packageName: "com.globalaccelerex.transaction",
    extraData: jsonString,
  );
  BaseAppTransactionResponse response =
      BaseAppTransactionResponse.fromJson(jsonDecode(result ?? ""));
  print('Transaction Response: $result');
  print("To String: $response");
}

void sendToPrintCardTransaction(BaseAppTransactionResponse response) async {
  final data = getJsonForPrintingCardTransaction(response);
  await startIntentPrinterAndGetResult(
    packageName: "com.globalaccelerex.printer",
    extraData: jsonEncode(data),
  );
}
