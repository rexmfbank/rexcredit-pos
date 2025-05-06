import 'rex_api_exception.dart';

class CompleteSecondOnboardException extends RexApiException {
  CompleteSecondOnboardException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class CompleteVerifyOTPException extends RexApiException {
  CompleteVerifyOTPException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class CompleteTransactionPINException extends RexApiException {
  CompleteTransactionPINException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class InvalidDeviceException extends RexApiException {
  InvalidDeviceException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class CompleteBusinessInfoException extends RexApiException {
  CompleteBusinessInfoException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class CompleteBusinessDocsException extends RexApiException {
  CompleteBusinessDocsException(this.exception);

  final String exception;

  String get errorMessage => exception;
}

class CompleteBusinessDirectorsException extends RexApiException {
  CompleteBusinessDirectorsException(this.exception);

  final String exception;

  String get errorMessage => exception;
}
