import 'dart:developer' as devtools show log;

extension Log on Object? {
  /// prints a log to the console and if the object is null,
  /// it prints the NULL value with a colorful textstyle.
  void log() {
    devtools.log(this?.toString() ?? '\x1b[101m\x1b[30mNULL\x1b[0m');
  }
}

extension NotNull on Object? {
  bool get isNotNull {
    if (this != null) {
      return true;
    } else {
      return false;
    }
  }
}
