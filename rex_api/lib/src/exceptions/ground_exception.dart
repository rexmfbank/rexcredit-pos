
import 'package:rex_api/src/exceptions/rex_api_exception.dart';

class GroundException extends RexApiException {
  final String exception;
  GroundException(this.exception);

  @override
  String get errorMessage => exception;
}