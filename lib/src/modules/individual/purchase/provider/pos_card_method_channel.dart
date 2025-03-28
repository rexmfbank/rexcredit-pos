import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_transaction_response.dart';
import 'package:rex_app/src/modules/individual/purchase/model/intent_utility_response.dart';

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

void sendToTransaction() async {
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

void sendToPrinter() async {
  final result = await startIntentAndGetResult(
    packageName: "com.globalaccelerex.printer",
    extraData: jsonString, // jsonEncode(receiptJson),
  );
  print("Printer Response: $result");
}

String jsonString = '''
{
  "Receipt": [
    {
      "Bitmap": "filename",
      "letterSpacing": 5,
      "String": [
        {
          "isMultiline": true,
          "header": {
            "text": "Merchant Name",
            "align": "centre",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "Global Accelerex",
            "alignment": "centre",
            "size": "normal",
            "isBold": false
          }
        },
        {
          "isMultiline": false,
          "header": {
            "text": "Reference Number",
            "align": "left",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "123456789"
          }
        }
      ]
    },
    {
      "Bitmap": "filename",
      "letterSpacing": 5,
      "String": [
        {
          "isMultiline": true,
          "header": {
            "text": "Merchant Name",
            "align": "centre",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "Allen Tobi",
            "alignment": "centre",
            "size": "normal",
            "isBold": false
          }
        },
        {
          "isMultiline": false,
          "header": {
            "text": "Reference Number",
            "align": "left",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "abcd1234"
          }
        }
      ]
    }
  ]
}
''';

final receiptJson = {
  "Receipt": [
    {
      "Bitmap": "filename",
      "letterSpacing": 5,
      "String": [
        {
          "isMultiline": true,
          "header": {
            "text": "Merchant Name",
            "align": "centre",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "Global Accelerex",
            "alignment": "centre",
            "size": "normal",
            "isBold": false
          }
        },
        {
          "isMultiline": false,
          "header": {
            "text": "Reference Number",
            "align": "left",
            "size": "large",
            "isBold": true
          },
          "body": {"text": "123456789"}
        }
      ]
    },
    {
      "Bitmap": "filename",
      "letterSpacing": 5,
      "String": [
        {
          "isMultiline": true,
          "header": {
            "text": "Merchant Name",
            "align": "centre",
            "size": "large",
            "isBold": true
          },
          "body": {
            "text": "Allen Tobi",
            "alignment": "centre",
            "size": "normal",
            "isBold": false
          }
        },
        {
          "isMultiline": false,
          "header": {
            "text": "Reference Number",
            "align": "left",
            "size": "large",
            "isBold": true
          },
          "body": {"text": "abcd1234"}
        }
      ]
    }
  ]
};
