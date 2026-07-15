abstract class StringRegex {
  /// this regex validates an email address
  static const email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// regex validates whether a password string
  /// contains an Upper case letter
  static const passUpperCase = r'[A-Z]';

  /// regex validates whether a password string
  /// contains a Lower case letter
  static const passLowerCase = r'[a-z]';

  /// regex validates whether a password string contains a symbol
  static const passSymbol = r'[!@#\$&*~,.;:?]';

  /// regex validates whether a password string contains a digit
  static const passNumber = r'[0-9]';

  /// regex validates whether a password string is at least 8 characters
  static const pass8Chars = r'.{8,}';

  /// regex validates that a person names contains only letters and or hyphens
  /// any other character or digits makes it invalid
  static const personName = r'^[a-zA-Z-]+$';
}
