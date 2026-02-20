import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:rex_app/src/modules/revamp/api/rex_api.dart';

abstract class EncryptionUtils {
  static final devRequestKey = Key.fromUtf8(_StringKeys.devRequestKey);
  static final devRequestIV = IV.fromUtf8(_StringKeys.devRequestIV);
  static final devReqCrypt = Encrypter(AES(devRequestKey, mode: AESMode.cbc));
  //
  static final devResponseKey = Key.fromUtf8(_StringKeys.devResponseKey);
  static final devResponseIV = IV.fromUtf8(_StringKeys.devResponseIV);
  static final devResCrypt = Encrypter(AES(devResponseKey, mode: AESMode.cbc));

  static final prodRequestKey = Key.fromUtf8(_StringKeys.prodRequestKey);
  static final prodRequestIV = IV.fromUtf8(_StringKeys.prodRequestIV);
  static final prodReqCrypt = Encrypter(AES(prodRequestKey, mode: AESMode.cbc));
  //
  static final prodResponseKey = Key.fromUtf8(_StringKeys.prodResponseKey);
  static final prodResponseIV = IV.fromUtf8(_StringKeys.prodResponseIV);
  static final prodResCrypt =
      Encrypter(AES(prodResponseKey, mode: AESMode.cbc));

  static String _encryptData(String input) {
    late Encrypted encrypted;
    if (ApiConfig.shared.flavor == ApiFlavor.dev) {
      encrypted = devReqCrypt.encrypt(input, iv: devRequestIV);
    } else {
      encrypted = prodReqCrypt.encrypt(input, iv: prodRequestIV);
    }
    return encrypted.base64;
  }

  static String _decryptData(String input) {
    late String decrypted;
    if (ApiConfig.shared.flavor == ApiFlavor.dev) {
      decrypted = devResCrypt.decrypt(
        Encrypted.fromBase64(input),
        iv: devResponseIV,
      );
    } else {
      decrypted = prodResCrypt.decrypt(
        Encrypted.fromBase64(input),
        iv: prodResponseIV,
      );
    }
    return decrypted;
  }

  static String encryptToApi(Map<String, dynamic> json) {
    final jsonRequestString = jsonEncode(json);
    final encryptedRequest = _encryptData(jsonRequestString);
    return encryptedRequest;
  }

  static dynamic decryptFromApi(jsonMap) {
    final encryptedResponse = _EncryptedResponse.fromJson(jsonMap);
    final jsonString = _decryptData(encryptedResponse.data);
    final jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }

  static String encryptString(String input) {
    return _encryptData(input);
  }
}

abstract class _StringKeys {
  static final devRequestKey = 'n22raoNPcTX4IcPg';
  static final devRequestIV = 'BGo2fBlnwdRuFlso';

  static final devResponseKey = 'SMg30grqgIIYSul3';
  static final devResponseIV = 'cHgowixgkGnXYmgj';

  static final prodRequestKey = 'srgCWI88B96FYj4L';
  static final prodRequestIV = 'ywlfhExdmOm2y5Gn';

  static final prodResponseKey = 'RfcWiPumGEFZ99L6';
  static final prodResponseIV = 'g3y09svKpDZQVYyq';
}

class _EncryptedResponse {
  final String data;

  const _EncryptedResponse(this.data);

  factory _EncryptedResponse.fromJson(Map<String, dynamic> json) {
    return _EncryptedResponse(json['data']);
  }
}
