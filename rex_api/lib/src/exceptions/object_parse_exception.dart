
import 'package:rex_api/src/exceptions/rex_api_exception.dart';

class ObjectParseException extends RexApiException {
   ObjectParseException();

  @override
  String get errorMessage => 'We encountered a problem trying to reach the server. We are working to fix it...';
}