import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

class AppKeys {
  final String serialNumber;
  final String merchantId;
  final String terminalId;
  final String baasNuban;
  final String baasNubanName;
  final String baasTerminalId;
  final String authToken;
  final String appVersionLocal;
  final String appVersionServer;
  final String isDeviceActive;
  final String isAppUpdated;
  final String isExchangeDone;
  final String isAuthFailed;
  final String location;
  final String loginUsername;
  final String loginPassword;
  final String loginAuthToken;
  final String loginNuban;
  final String loginFullname;
  final String loginFirstname;
  final bool loginHideAccount;
  final String baseappName;
  final String printImage;
  final DateTime lastUpdatedAt;
  final int borrowerID;
  final String latitude;
  final String longitude;

  AppKeys({
    required this.serialNumber,
    required this.merchantId,
    required this.terminalId,
    required this.baasNuban,
    required this.baasNubanName,
    required this.baasTerminalId,
    required this.authToken,
    required this.loginAuthToken,
    required this.appVersionLocal,
    required this.appVersionServer,
    required this.isDeviceActive,
    required this.isAppUpdated,
    required this.isExchangeDone,
    required this.isAuthFailed,
    required this.location,
    required this.loginUsername,
    required this.loginPassword,
    required this.loginNuban,
    required this.loginFullname,
    required this.loginFirstname,
    required this.loginHideAccount,
    required this.baseappName,
    required this.printImage,
    required this.lastUpdatedAt,
    required this.borrowerID,
    required this.latitude,
    required this.longitude,
  });

  factory AppKeys.empty() {
    return AppKeys(
      serialNumber: '',
      merchantId: '',
      terminalId: '',
      baasNuban: '',
      baasNubanName: '',
      baasTerminalId: '',
      authToken: '',
      loginAuthToken: '',
      appVersionLocal: '',
      appVersionServer: '',
      isDeviceActive: '',
      isAppUpdated: '',
      isExchangeDone: '',
      isAuthFailed: '',
      location: '',
      loginUsername: '',
      loginPassword: '',
      loginNuban: '',
      loginFullname: '',
      loginFirstname: '',
      loginHideAccount: false,
      baseappName: '',
      printImage: '',
      lastUpdatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      borrowerID: 0,
      latitude: '',
      longitude: '',
    );
  }

  bool get isComplete =>
      serialNumber.isNotEmpty &&
      authToken.isNotEmpty &&
      baasNuban.isNotEmpty &&
      baasTerminalId.isNotEmpty;

  bool get isFresh => DateTime.now().difference(lastUpdatedAt).inHours < 10;

  @override
  String toString() {
    return 'AppKeys('
        'serialNumber: $serialNumber, '
        'merchantId: $merchantId, '
        'terminalId: $terminalId, '
        'baasNuban: $baasNuban, '
        'baasNubanName: $baasNubanName, '
        'baasTerminalId: $baasTerminalId, '
        'authToken: $authToken, '
        'appVersionLocal: $appVersionLocal, '
        'appVersionServer: $appVersionServer, '
        'isDeviceActive: $isDeviceActive, '
        'isAppUpdated: $isAppUpdated, '
        'isExchangeDone: $isExchangeDone, '
        'isAuthFailed: $isAuthFailed, '
        'location: $location, '
        'loginUsername: $loginUsername, '
        'loginPassword: $loginPassword, '
        'loginAuthToken: $loginAuthToken, '
        'loginNuban: $loginNuban, '
        'loginFullname: $loginFullname, '
        'loginFirstname: $loginFirstname, '
        'loginHideAccount: $loginHideAccount, '
        'lastUpdatedAt: $lastUpdatedAt, '
        'baseappName: $baseappName, '
        'printImage: $printImage, '
        'isComplete: $isComplete, '
        'isFresh: $isFresh, '
        'longitude: $longitude, '
        'latitude: $latitude, '
        'borrowerID: $borrowerID)';
  }

  AppKeys copyWith({
    String? serialNumber,
    String? merchantId,
    String? terminalId,
    String? baasNuban,
    String? baasNubanName,
    String? baasTerminalId,
    String? authToken,
    String? appVersionLocal,
    String? appVersionServer,
    String? isDeviceActive,
    String? isAppUpdated,
    String? isExchangeDone,
    String? isAuthFailed,
    String? location,
    String? loginUsername,
    String? loginPassword,
    String? loginAuthToken,
    String? loginNuban,
    String? loginFullname,
    String? loginFirstname,
    bool? loginHideAccount,
    String? baseappName,
    String? printImage,
    DateTime? lastUpdatedAt,
    int? borrowerID,
    String? longitude,
    String? latitude,
  }) {
    return AppKeys(
      serialNumber: serialNumber ?? this.serialNumber,
      merchantId: merchantId ?? this.merchantId,
      terminalId: terminalId ?? this.terminalId,
      baasNuban: baasNuban ?? this.baasNuban,
      baasNubanName: baasNubanName ?? this.baasNubanName,
      baasTerminalId: baasTerminalId ?? this.baasTerminalId,
      authToken: authToken ?? this.authToken,
      appVersionLocal: appVersionLocal ?? this.appVersionLocal,
      appVersionServer: appVersionServer ?? this.appVersionServer,
      isDeviceActive: isDeviceActive ?? this.isDeviceActive,
      isAppUpdated: isAppUpdated ?? this.isAppUpdated,
      isExchangeDone: isExchangeDone ?? this.isExchangeDone,
      isAuthFailed: isAuthFailed ?? this.isAuthFailed,
      location: location ?? this.location,
      loginUsername: loginUsername ?? this.loginUsername,
      loginPassword: loginPassword ?? this.loginPassword,
      loginAuthToken: loginAuthToken ?? this.loginAuthToken,
      loginNuban: loginNuban ?? this.loginNuban,
      loginFullname: loginFullname ?? this.loginFullname,
      loginFirstname: loginFirstname ?? this.loginFirstname,
      loginHideAccount: loginHideAccount ?? this.loginHideAccount,
      baseappName: baseappName ?? this.baseappName,
      printImage: printImage ?? this.printImage,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      borrowerID: borrowerID ?? this.borrowerID,
    );
  }
}

class AppKeysAdapter extends TypeAdapter<AppKeys> {
  @override
  final int typeId = 0;

  @override
  AppKeys read(BinaryReader reader) {
    return AppKeys(
      serialNumber: reader.readString(),
      merchantId: reader.readString(),
      terminalId: reader.readString(),
      baasNuban: reader.readString(),
      baasNubanName: reader.readString(),
      baasTerminalId: reader.readString(),
      authToken: reader.readString(),
      appVersionLocal: reader.readString(),
      appVersionServer: reader.readString(),
      isDeviceActive: reader.readString(),
      isAppUpdated: reader.readString(),
      isExchangeDone: reader.readString(),
      isAuthFailed: reader.readString(),
      location: reader.readString(),
      loginUsername: reader.readString(),
      loginPassword: reader.readString(),
      loginAuthToken: reader.readString(),
      loginNuban: reader.readString(),
      loginFullname: reader.readString(),
      loginFirstname: reader.readString(),
      loginHideAccount: reader.readBool(),
      baseappName: reader.readString(),
      printImage: reader.readString(),
      lastUpdatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      borrowerID: reader.readInt(),
      latitude: reader.readString(),
      longitude: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, AppKeys obj) {
    writer.writeString(obj.serialNumber);
    writer.writeString(obj.merchantId);
    writer.writeString(obj.terminalId);
    writer.writeString(obj.baasNuban);
    writer.writeString(obj.baasNubanName);
    writer.writeString(obj.baasTerminalId);
    writer.writeString(obj.authToken);
    writer.writeString(obj.appVersionLocal);
    writer.writeString(obj.appVersionServer);
    writer.writeString(obj.isDeviceActive);
    writer.writeString(obj.isAppUpdated);
    writer.writeString(obj.isExchangeDone);
    writer.writeString(obj.isAuthFailed);
    writer.writeString(obj.location);
    writer.writeString(obj.loginUsername);
    writer.writeString(obj.loginPassword);
    writer.writeString(obj.loginAuthToken);
    writer.writeString(obj.loginNuban);
    writer.writeString(obj.loginFullname);
    writer.writeString(obj.loginFirstname);
    writer.writeBool(obj.loginHideAccount);
    writer.writeString(obj.baseappName);
    writer.writeString(obj.printImage);
    writer.writeInt(obj.lastUpdatedAt.millisecondsSinceEpoch);
    writer.writeInt(obj.borrowerID);
    writer.writeString(obj.latitude);
    writer.writeString(obj.longitude);
  }
}

class AppKeysStorage {
  static const String _boxName = 'pos_config_box';
  static const String _secureKeyName = 'hive_encryption_key_pos';
  static const String _configKey = 'pos_device_config_data';

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      synchronizable: false,
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppKeysAdapter());

    try {
      String? encryptionKeyString = await _secureStorage.read(
        key: _secureKeyName,
      );
      if (encryptionKeyString == null) {
        final key = Hive.generateSecureKey();
        await _secureStorage.write(
          key: _secureKeyName,
          value: base64UrlEncode(key),
        );
        encryptionKeyString = base64UrlEncode(key);
      }

      final encryptionKeyUint8List = base64Url.decode(encryptionKeyString);
      await Hive.openBox<AppKeys>(
        _boxName,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
      );
    } catch (e) {
      debugPrintDev('Hive init failed: $e. Falling back to unencrypted.');
      try {
        await _secureStorage.delete(key: _secureKeyName);
      } catch (_) {}
      await Hive.openBox<AppKeys>(_boxName);
    }
  }

  static AppKeys getConfig() {
    if (!Hive.isBoxOpen(_boxName)) return AppKeys.empty();
    final box = Hive.box<AppKeys>(_boxName);
    try {
      return box.get(_configKey) ?? AppKeys.empty();
    } catch (e) {
      box.delete(_configKey);
      return AppKeys.empty();
    }
  }

  static Future<void> saveConfig(AppKeys config) async {
    final box = Hive.box<AppKeys>(_boxName);
    await box.put(_configKey, config);
  }

  static Future<void> clearConfig() async {
    final box = Hive.box<AppKeys>(_boxName);
    await box.delete(_configKey);
  }
}
