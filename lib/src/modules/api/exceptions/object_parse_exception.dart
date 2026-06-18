import 'rex_api_exception.dart';

class ObjectParseException extends RexApiException {
  ObjectParseException()
    : super(
        message: 'Failed to parse server response',
        responseCode: 'PARSE_ERR',
        responseMessage: 'Failed to parse server response',
      );

  String get errorMessage => 'Failed to parse server response';
}
