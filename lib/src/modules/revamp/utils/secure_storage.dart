import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      synchronizable: false,
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  final sharedPrefs = SharedPreferences.getInstance();

  static const userName = "userName";
  static const password = "password";
  static const posNuban = 'pos_nuban';
  static const posSerialNum = "pos_serial_num";
  static const posNubanName = 'pos_nuban_name';
  static const posMerchantId = 'pos_merchant_id';
  static const posTerminalId = 'pos_terminal_id';

  set userNameVal(String value) => storage.write(key: userName, value: value);
  set passwordVal(String value) => storage.write(key: password, value: value);
  set posNubanValue(String value) => storage.write(key: posNuban, value: value);

  set posSerialNoValue(String value) =>
      storage.write(key: posSerialNum, value: value);
  set posNubanNameValue(String value) =>
      storage.write(key: posNubanName, value: value);

  set posMerchantIdValue(String value) =>
      storage.write(key: posMerchantId, value: value);
  set posTerminalIdValue(String value) =>
      storage.write(key: posTerminalId, value: value);

  Future<String?> getUserName() async {
    return await storage.read(key: userName);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: password);
  }

  Future<String?> getPosNuban() async {
    return await storage.read(key: posNuban);
  }

  Future<String?> getPosSerialNo() async {
    return await storage.read(key: posSerialNum);
  }

  Future<String?> getPosNubanName() async {
    return await storage.read(key: posNubanName);
  }

  Future<String?> getPosMerchantId() async {
    return await storage.read(key: posMerchantId);
  }

  Future<String?> getPosTerminalId() async {
    return await storage.read(key: posTerminalId);
  }
}
