import 'package:rex_app/src/modules/api/api_config.dart';

abstract class ApiHeaders {
  static final _clientId =
      ApiConfig.shared.flavor == ApiFlavor.dev
          ? 'X0sJL7tQpQ95fHD2yMz4EuNdxYwVbKChlBgWmRvskOAj6ITmUdS38PnczYaiFB1XRqGRN2ZTy'
          : 'BAASCORE_801676262046810870515387404330';

  static final _clientSecret =
      ApiConfig.shared.flavor == ApiFlavor.dev
          ? '5fHD2yMz4EuNdxYwVbKChlBgWmRvskOAj6ITmUdS38PnczYaiFB1XRqGRN2ZTyX0sJL7tQpQ9'
          : 'eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJCQUFTQ09SRSIsImlhdCI6MTcwODUwMjg1MCwic3ViIjoiQkFBU0NPUkUiLCJpc3MiOiJCQUFTQ09SRSIsImV4cCI6MTcwNjcxMTE1M30.qFtwC7sz_6IX7as598tudCDoNCctq7ezMYjL_194DQk';

  static final sourceCode =
      ApiConfig.shared.flavor == ApiFlavor.dev ? 'APPBAWEB' : 'REXMOBILEAPP';

  static const sourceCodeKey = 'x-source-code';
  static const clientIdKey = 'x-client-id';
  static const clientSecretKey = 'x-client-secret';
  static const authorizationKey = 'Authorization';
  static const pinKey = 'x-enc-pwd';
  static const pushID = 'x-push-id';
  static const deviceIdKey = 'x-device-id';
  static const contentTypeKey = "Content-Type";
  static const contentType = "application/json";
  static const terminalSecret = "x-terminal-secret";
  static const platformKey = "x-platform";
  static const platform = "Android";
  static const appversionKey = 'x-appversion';
  static const geolocationKey = 'geolocation';
  static const channelKey = "x-channel";
  static const channel = "POS";
  static const geoLongKey = "x-lon";
  static const geoLatKey = "x-lat";
  static const companyIdKey = 'X-Company-ID';
  static const companyID = 9;

  static noAuthNoCrypt(HeaderNoAuthNoCrypt header) {
    return {
      clientIdKey: _clientId,
      clientSecretKey: _clientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: header.appVersion,
      contentTypeKey: contentType,
      deviceIdKey: header.deviceID,
      platformKey: platform,
      channelKey: channel,
      geoLongKey: header.geoLong,
      geoLatKey: header.geoLat,
      companyIdKey: companyID,
    };
  }

  static withAuthNoCrypt(HeaderWithAuthNoCrypt header) {
    return {
      clientIdKey: _clientId,
      clientSecretKey: _clientSecret,
      sourceCodeKey: sourceCode,
      appversionKey: header.appVersion,
      contentTypeKey: contentType,
      deviceIdKey: header.deviceID,
      platformKey: platform,
      channelKey: channel,
      geoLongKey: header.geoLong,
      geoLatKey: header.geoLat,
      companyIdKey: companyID,
      authorizationKey: 'Bearer ${header.authToken}',
    };
  }
}

class HeaderNoAuthNoCrypt {
  final String appVersion;
  final String deviceID;
  final String geoLong;
  final String geoLat;

  const HeaderNoAuthNoCrypt({
    required this.appVersion,
    required this.deviceID,
    required this.geoLong,
    required this.geoLat,
  });

  Map<String, dynamic> toJson() {
    return {
      'appVersion': appVersion,
      'deviceID': deviceID,
      'geoLong': geoLong,
      'geoLat': geoLat,
    };
  }
}

class HeaderWithAuthNoCrypt {
  final String appVersion;
  final String deviceID;
  final String geoLong;
  final String geoLat;
  final String authToken;

  const HeaderWithAuthNoCrypt({
    required this.appVersion,
    required this.deviceID,
    required this.authToken,
    required this.geoLong,
    required this.geoLat,
  });

  Map<String, dynamic> toJson() {
    return {
      'appVersion': appVersion,
      'deviceID': deviceID,
      'authToken': authToken,
      'geoLong': geoLong,
      'geoLat': geoLat,
    };
  }
}
