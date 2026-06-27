import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

class ApiException implements Exception {
  final Object message;
  final String status;

  ApiException({required this.message, required this.status});

  @override
  String toString() => 'ApiException: ${message.toString()} (Status: $status)';
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

    case DioExceptionType.badCertificate:
      return 'Secure connection failed. Invalid server certificate.';

    case DioExceptionType.badResponse:
      // This covers 4xx and 5xx responses where the body wasn't a standard error map
      final statusCode = e.response?.statusCode;
      return 'Server responded with an error status: $statusCode.';

    case DioExceptionType.cancel:
      return 'The request was cancelled.';

    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network settings.';

    case DioExceptionType.unknown:
      // This typically catches lower-level SocketExceptions (e.g., host lookup failures)
      if (e.message?.contains('SocketException') ?? false) {
        return 'Cannot reach the server. Please check your internet connection.';
      }
      return 'An unexpected network error occurred.';
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
