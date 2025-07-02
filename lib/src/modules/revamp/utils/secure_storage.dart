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

  set userNameVal(String value) => storage.write(key: userName, value: value);
  set passwordVal(String value) => storage.write(key: password, value: value);
  set posNubanValue(String value) => storage.write(key: posNuban, value: value);

  Future<String?> getUserName() async {
    return await storage.read(key: userName);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: password);
  }

  Future<String?> getPosNuban() async {
    return await storage.read(key: posNuban);
  }
}
