import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/api_config.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/src/utils/encryption_utils.dart';

abstract class ApiHeaders {
  static const clientIdKey = 'x-client-id';
  static final _clientId = ApiConfig.shared.flavor == ApiFlavor.dev
      ? 'X0sJL7tQpQ95fHD2yMz4EuNdxYwVbKChlBgWmRvskOAj6ITmUdS38PnczYaiFB1XRqGRN2ZTy'
      : 'BAASCORE_801676262046810870515387404330';

  static const clientSecretKey = 'x-client-secret';
  static final _clientSecret = ApiConfig.shared.flavor == ApiFlavor.dev
      ? '5fHD2yMz4EuNdxYwVbKChlBgWmRvskOAj6ITmUdS38PnczYaiFB1XRqGRN2ZTyX0sJL7tQpQ9'
      : 'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJCQUFTQ09SRSIsImlhdCI6MTcwODUwMjg1MCwic3ViIjoiQkFBU0NPUkUiLCJpc3MiOiJCQUFTQ09SRSIsImV4cCI6MTcwNjcxMTE1M30.qFtwC7sz_6IX7as598tudCDoNCctq7ezMYjL_194DQk';

  static const sourceCodeKey = 'x-source-code';
  static final sourceCode =
      ApiConfig.shared.flavor == ApiFlavor.dev ? 'APPBAWEB' : 'REXMOBILEAPP';

  static const authorizationKey = 'Authorization';
  static const pinKey = 'x-enc-pwd';
  static const pushID = 'x-push-id';
  static const deviceId = 'x-device-id';
  static const contentTypeKey = "Content-Type";
  static const contentType = "application/json";
  static const terminalSecret = "x-terminal-secret";

  static const appversionKey = 'appversion';

  static const appversion = '1.0.0';

  late var version;
  Future<void> deviceCheck() async {
    var deviceInfo = await PackageInfo.fromPlatform();
    version = deviceInfo.version;
  }

  static final headerNoTokenI = {
    clientIdKey: _clientId,
    clientSecretKey: _clientSecret,
    sourceCodeKey: sourceCode,
    appversionKey: appversion,
    contentTypeKey: contentType,
  };

  static headerNoTokenII(String appVersion) => {
        clientIdKey: _clientId,
        clientSecretKey: _clientSecret,
        sourceCodeKey: sourceCode,
        appversionKey: appVersion,
        contentTypeKey: contentType,
      };

  static headerNoTokenEncrypted() {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);
    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: appversion,
      contentTypeKey: contentType,
    };
  }

  static headerWithAppToken(String appVersion, String authToken) => {
        clientIdKey: _clientId,
        clientSecretKey: _clientSecret,
        sourceCodeKey: sourceCode,
        appversionKey: appVersion,
        contentTypeKey: contentType,
        authorizationKey: 'Bearer $authToken'
      };

  static headerWithTerminalToken(String appVersion, String authToken) => {
        clientIdKey: _clientId,
        clientSecretKey: _clientSecret,
        sourceCodeKey: sourceCode,
        appversionKey: appVersion,
        contentTypeKey: contentType,
        terminalSecret: authToken,
      };

  static headerCryptedNoToken() async {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);
    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: appversion,
    };
  }

  static requestHeaderCrypted(String? xAppVersion) {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);
    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: (xAppVersion != null && xAppVersion.isNotEmpty)
          ? xAppVersion
          : appversion,
    };
  }

  static loginRequestHeader(String pushId, {String? xAppVersion}) {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);
    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      pushID: pushId,
      appversionKey: (xAppVersion != null && xAppVersion.isNotEmpty)
          ? xAppVersion
          : appversion,
    };
  }

  static requestHeaderWithToken(String token) => {
        clientIdKey: _clientId,
        clientSecretKey: _clientSecret,
        sourceCodeKey: sourceCode,
        appversionKey: appversion,
        contentTypeKey: contentType,
        authorizationKey: 'Bearer $token',
      };

  static requestHeaderWithTokenEncrypted(String token) {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);

    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: appversion,
      contentTypeKey: contentType,
      authorizationKey: 'Bearer $token',
    };
  }

  static registerHeader(String? xAppVersion) {
    final cryptClientId = EncryptionUtils.encryptString(_clientId);
    final cryptClientSecret = EncryptionUtils.encryptString(_clientSecret);
    return {
      clientIdKey: cryptClientId,
      clientSecretKey: cryptClientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: (xAppVersion != null && xAppVersion.isNotEmpty)
          ? xAppVersion
          : appversion,
      contentTypeKey: contentType,
    };
  }

  static transactionRequestHeaderToken(
    String token, {
    String? transactionPin = '',
    String? xDeviceId = '',
    String? xContentType = '',
  }) {
    return {
      clientIdKey: _clientId,
      clientSecretKey: _clientSecret,
      sourceCodeKey: sourceCode,
      contentTypeKey: (xContentType != null && xContentType.isNotEmpty)
          ? xContentType
          : contentType,
      authorizationKey: 'Bearer $token',
      pinKey: transactionPin,
      deviceId: xDeviceId,
      appversionKey: appversion,
    };
  }

  static encryptedTransactionRequestHeaderToken(
    String token, {
    String? transactionPin = '',
    String? xDeviceId = '',
    required String xAppVersion,
  }) {
    return {
      clientIdKey: EncryptionUtils.encryptString(_clientId),
      clientSecretKey: EncryptionUtils.encryptString(_clientSecret),
      sourceCodeKey: sourceCode,
      contentTypeKey: contentType,
      authorizationKey: 'Bearer $token',
      pinKey: (transactionPin != null && transactionPin.isNotEmpty)
          ? EncryptionUtils.encryptString(transactionPin)
          : transactionPin,
      deviceId: (xDeviceId != null && xDeviceId.isNotEmpty)
          ? EncryptionUtils.encryptString(xDeviceId)
          : xDeviceId,
      appversionKey: xAppVersion,
    };
  }
}
