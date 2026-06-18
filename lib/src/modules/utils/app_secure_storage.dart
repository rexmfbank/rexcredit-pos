import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSecureStorage {
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

  static const baasNuban = 'pos_nuban';
  static const baasNubanName = 'pos_nuban_name';
  static const baasTerminalId = 'baas_terminal_id';

  static const posSerialNum = "pos_serial_num";
  static const posMerchantId = 'pos_merchant_id';
  static const posTerminalId = 'pos_terminal_id';

  set userNameVal(String value) => storage.write(key: userName, value: value);
  set passwordVal(String value) => storage.write(key: password, value: value);

  set setBaasNuban(String value) => storage.write(key: baasNuban, value: value);
  set setBaasNubanName(String value) =>
      storage.write(key: baasNubanName, value: value);
  set baasTerminalIdValue(String value) =>
      storage.write(key: baasTerminalId, value: value);

  set posSerialNoValue(String value) =>
      storage.write(key: posSerialNum, value: value);
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

  Future<String?> getBaasNuban() async {
    return await storage.read(key: baasNuban);
  }

  Future<String?> getPosSerialNo() async {
    return await storage.read(key: posSerialNum);
  }

  Future<String?> getBaasNubanName() async {
    return await storage.read(key: baasNubanName);
  }

  Future<String?> getPosMerchantId() async {
    return await storage.read(key: posMerchantId);
  }

  Future<String?> getPosTerminalId() async {
    return await storage.read(key: posTerminalId);
  }

  Future<String?> getBaasTerminalId() async {
    return await storage.read(key: baasTerminalId);
  }
}
