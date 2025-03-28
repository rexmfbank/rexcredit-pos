import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      synchronizable: false,
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  final sharedPrefs = SharedPreferences.getInstance();

  static const userName = "userName";
  static const password = "password";
  static const launchState = "launchState";
  static const isOnBoarding = 'isOnBoarding';
  static const firstLaunch = 'firstLaunch';
  static const loggedOut = 'loggedOut';
  static const loggedIn = 'loggedIn';

  void setLaunchStateVal(String value) async =>
      await (await sharedPrefs).setString(launchState, value);
  set userNameVal(String value) => storage.write(key: userName, value: value);
  set passwordVal(String value) => storage.write(key: password, value: value);
  // void userNameVal(String value) async =>
  //     await (await sharedPrefs).setString(userName, value);
  // void passwordVal(String value) async =>
  //     await (await sharedPrefs).setString(password, value);

  Future<String?> getUserName() async {
    return await storage.read(key: userName);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: password);
  }

  Future<String> getLaunchState() async {
    return (await sharedPrefs).getString(launchState) ?? "FL";
  }

  // Future<String> getUserName() async {
  //   return (await sharedPrefs).getString(userName) ?? "";
  // }
  //
  // Future<String> getPassword() async {
  //   return (await sharedPrefs).getString(password) ?? "";
  // }
}
