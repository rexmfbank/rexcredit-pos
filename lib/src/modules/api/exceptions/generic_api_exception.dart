import 'rex_api_exception.dart';

class GenericApiException extends RexApiException {
  final String exception;
  GenericApiException(this.exception)
    : super(
        message: exception,
        responseCode: 'GENERIC_API_ERR',
        responseMessage: exception,
      );

  String get errorMessage => exception;
}
