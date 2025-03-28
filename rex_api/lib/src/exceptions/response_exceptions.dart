import 'package:rex_api/src/exceptions/rex_api_exception.dart';
import 'package:dio/dio.dart';

class ResponseException extends RexApiException  {
  String? message;
  String? code;

  ResponseException({
    this.message,
    this.code,
  });

  factory ResponseException.fromDio(Object dioError) =>
      _handleCallErrors(dioError);

  factory ResponseException.fromJson(Map json) => ResponseException(
        message: json['message'],
        code: json['code'],
      );

  static ResponseException _handleCallErrors(Object error) {
    late final ResponseException exception;
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          exception = ResponseException(message: "Request was cancelled");
          break;
        case DioExceptionType.connectionTimeout:
          exception = ResponseException(message: "Connection timeout");
          break;
        case DioExceptionType.unknown:
          exception = ResponseException(
              message: "Connection failed due to internet connection");
          break;
        case DioExceptionType.receiveTimeout:
          exception =
              ResponseException(message: "Receive timeout in connection");
          break;
        case DioExceptionType.badResponse:
          if (dioError.response?.statusCode == 405) {
            throw ResponseException(
                message: 'An Error Occurred. We\'re working to fix it');
          }
          if ((dioError.response?.statusCode ?? 400) >= 500) {
            throw ResponseException(
                message: 'An Error Occurred. We\'re working to fix it');
          }
          exception = ResponseException.fromJson(dioError.response!.data);
          break;
        case DioExceptionType.sendTimeout:
          exception = ResponseException(message: "Send timeout in connection");
          break;
      }
    } else {
      exception = ResponseException(message: "An unexpected error occurred");
    }

    return exception;
  }
}
