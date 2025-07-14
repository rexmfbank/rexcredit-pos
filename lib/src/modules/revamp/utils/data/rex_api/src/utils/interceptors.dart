import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
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
          error: 'Internet connection lost',
        ),
      );
    }
    super.onRequest(options, handler);
  }
}

class ConnectionCheck {
  static final _connectivity = Connectivity();

  /// Returns true if device is connected to Wi-Fi or mobile
  /// **and** Internet is reachable.
  static Future<bool> isConnected() async {
    // Check network type (Wi-Fi, mobile, none)
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    }
    // Confirm actual Internet access by pinging reliable hosts
    return await InternetConnection().hasInternetAccess;
  }
}
