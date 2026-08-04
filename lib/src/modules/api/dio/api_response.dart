import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

class ApiException implements Exception {
  final Object message;
  final String status;

  ApiException({required this.message, required this.status});

  @override
  String toString() => message.toString();
}

/// Raised when the backend answers a login with `location_otp_required`,
/// meaning the credentials are valid but the login still has to be confirmed
/// with an OTP before a session is granted.
class LocationOtpRequiredException extends ApiException {
  LocationOtpRequiredException({
    required super.message,
    required super.status,
    required this.otpToken,
  });

  /// Short-lived token identifying the pending verification.
  final String otpToken;
}

class ApiResponse<T> {
  final String status;
  final Object message;
  final T? data;

  ApiResponse({required this.status, required this.message, this.data});

  // Factory to parse the incoming JSON map
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'] ?? 'error',
      message: json['message'] ?? 'Something went wrong',
      // If data is null or error, don't parse it.
      // Otherwise, parse it using the passed function.
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  // Helper to check if the backend considers this a successful transaction
  bool get isSuccess =>
      status.toLowerCase() == 'success' || status.toLowerCase() == 'true';
}

String mapDioExceptionToMessage(DioException e) {
  // 1. If the server actually responded with a payload,
  // prioritize the backend's message
  if (e.response != null && e.response?.data is Map) {
    final backendMessage = e.response?.data['message'];
    if (backendMessage != null && backendMessage.toString().isNotEmpty) {
      return backendMessage.toString();
    }
  }

  // 2. Exhaustive switch covering every single DioExceptionType
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timed out. Please check your internet connection and try again.';

    case DioExceptionType.sendTimeout:
      return 'Failed to send data to the server. Please try again.';

    case DioExceptionType.receiveTimeout:
      return 'The server took too long to respond. Please try again later.';

    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network settings.';

    case DioExceptionType.badResponse:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
    case DioExceptionType.cancel:
      // This typically catches lower-level SocketExceptions (e.g., host lookup failures)
      if (e.message?.contains('SocketException') ?? false) {
        return 'Cannot reach the server. Please check your internet connection.';
      }
      return 'An error occurred.';
  }
}

class ApiLib {
  static Dio? _instance;

  static Dio getDioInstance() {
    return _instance ??= _createDio();
  }

  static Dio _createDio() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: 50000),
        receiveTimeout: Duration(milliseconds: 50000),
      ),
    );
    dio.interceptors.add(EncryptionInterceptor());
    dio.interceptors.addAll([AppInterceptor(), ConnectivityInterceptor()]);
    dio.interceptors.add(
      PrettyDioLogger(
        responseBody: returnBoolForLogs(),
        error: returnBoolForLogs(),
        request: returnBoolForLogs(),
        requestBody: returnBoolForLogs(),
        requestHeader: returnBoolForLogs(),
        responseHeader: returnBoolForLogs(),
      ),
    );
    return dio;
  }
}
