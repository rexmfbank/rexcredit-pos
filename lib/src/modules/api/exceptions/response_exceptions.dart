import 'rex_api_exception.dart';
import 'package:dio/dio.dart';

class ResponseException extends RexApiException {
  ResponseException({
    super.message,
    super.responseCode,
    String? responseMessage,
  }) : super(responseMessage: responseMessage ?? message);

  factory ResponseException.fromDio(Object dioError) =>
      _handleCallErrors(dioError);

  factory ResponseException.fromJson(Map json) => ResponseException(
    message: json['responseMessage'] ?? json['message'],
    responseCode: json['responseCode'] ?? json['code'],
    responseMessage: json['responseMessage'] ?? json['message'],
  );

  static ResponseException _handleCallErrors(Object error) {
    late final ResponseException exception;
    if (error is DioException) {
      var dioError = error;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          exception = ResponseException(
            message: "Request was cancelled",
            responseCode: "REQ_CANCELLED",
            responseMessage: "Request was cancelled",
          );
          break;
        case DioExceptionType.connectionTimeout:
          exception = ResponseException(
            message: "Connection timeout",
            responseCode: "CONN_TIMEOUT",
            responseMessage: "Connection timeout",
          );
          break;
        case DioExceptionType.unknown:
          exception = ResponseException(
            message: "Internet connection lost!",
            responseCode: "NO_INTERNET",
            responseMessage: "Internet connection lost!",
          );
          break;
        case DioExceptionType.receiveTimeout:
          exception = ResponseException(
            message: "Receive timeout in connection",
            responseCode: "RECV_TIMEOUT",
            responseMessage: "Receive timeout in connection",
          );
          break;
        case DioExceptionType.badResponse:
          if (dioError.response?.statusCode == 405) {
            throw ResponseException(
              message: 'An Error Occurred. We\'re working to fix it',
              responseCode: "HTTP_405",
              responseMessage: 'An Error Occurred. We\'re working to fix it',
            );
          }
          if ((dioError.response?.statusCode ?? 400) >= 500) {
            // Try to extract responseCode/responseMessage from response body
            final data = dioError.response?.data;
            if (data is Map) {
              throw ResponseException(
                message:
                    data['responseMessage'] ??
                    'An Error Occurred. We\'re working to fix it',
                responseCode:
                    data['responseCode'] ??
                    'HTTP_${dioError.response?.statusCode}',
                responseMessage:
                    data['responseMessage'] ??
                    'An Error Occurred. We\'re working to fix it',
              );
            }
            throw ResponseException(
              message: 'An Error Occurred. We\'re working to fix it',
              responseCode: 'HTTP_${dioError.response?.statusCode}',
              responseMessage: 'An Error Occurred. We\'re working to fix it',
            );
          }
          // For other bad responses, try to parse the backend JSON format
          final data = dioError.response?.data;
          if (data is Map) {
            exception = ResponseException.fromJson(data);
          } else {
            exception = ResponseException(
              message: 'An Error Occurred',
              responseCode: 'HTTP_${dioError.response?.statusCode}',
              responseMessage: 'An Error Occurred',
            );
          }
          break;
        case DioExceptionType.sendTimeout:
          exception = ResponseException(
            message: "Send timeout in connection",
            responseCode: "SEND_TIMEOUT",
            responseMessage: "Send timeout in connection",
          );
          break;
        case DioExceptionType.badCertificate:
          exception = ResponseException(
            message: "An Error Occured",
            responseCode: "BAD_CERT",
            responseMessage: "An Error Occured",
          );
          break;
        case DioExceptionType.connectionError:
          exception = ResponseException(
            message: "Connection error",
            responseCode: "CONN_ERROR",
            responseMessage: "Connection error",
          );
          break;
      }
    } else {
      exception = ResponseException(
        message: "An unexpected error occurred",
        responseCode: "UNKNOWN",
        responseMessage: "An unexpected error occurred",
      );
    }

    return exception;
  }
}
