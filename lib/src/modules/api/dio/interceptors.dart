import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rex_app/src/modules/utils/crypt/crypto_utils.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    } else if (response.statusCode == 401) {
      response.statusCode = 401;
    }
    return super.onResponse(response, handler);
  }
}

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!await ConnectionCheck.isConnected()) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Internet connection lost!',
        ),
      );
    }
    super.onRequest(options, handler);
  }
}

class ConnectionCheck {
  static final _connectivity = Connectivity();
  static final _internetChecker = InternetConnection();

  /// Returns true if device is connected to Wi-Fi or mobile
  /// **and** Internet is reachable.
  static Future<bool> isConnected() async {
    // Check network type (Wi-Fi, mobile, none)
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    }
    // Confirm actual Internet access by pinging reliable hosts
    return await _internetChecker.hasInternetAccess;
  }
}

class EncryptionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final encryptionOn = AppKeysStorage.getConfig().onEncryption;
    debugPrintDev('ENCRYPTION STATUS: $encryptionOn');
    debugPrintDev('REQUEST DATA: ${options.data}');
    // Only encrypt if encryption is enabled AND there is a JSON body map
    if (encryptionOn &&
        options.data != null &&
        options.data is Map<String, dynamic>) {
      final encrypted = CryptoUtils.encryptPayload(options.data);
      options.data = {'enc': encrypted};
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final encryptionOn = AppKeysStorage.getConfig().onEncryption;
    // Only decrypt if encryption is enabled AND the response contains an "enc" field
    if (encryptionOn &&
        response.data != null &&
        response.data is Map &&
        response.data['enc'] != null) {
      final decrypted = CryptoUtils.decryptResponse(response.data['enc']);
      response.data = decrypted;
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final encryptionOn = AppKeysStorage.getConfig().onEncryption;
    // Also try to decrypt error response bodies
    if (encryptionOn &&
        err.response?.data != null &&
        err.response!.data is Map &&
        err.response!.data['enc'] != null) {
      try {
        final decrypted = CryptoUtils.decryptResponse(
          err.response!.data['enc'],
        );
        err.response!.data = decrypted;
      } catch (_) {
        // If decryption fails on error body, leave it as-is
      }
    }
    handler.next(err);
  }
}
