/// comment out the print function before creating a built for production
/// and return false for returnBoolForLogs
void debugPrintDev(String? message, {int? wrapWidth}) {
  // print("DEBUG_PRINT: $message");
}

/// return true for logs, false for no logs
bool returnBoolForLogs() {
  //return true;
  return false;
}

String returnTestLat() => '6.549043333333333';
String returnTestLong() => '3.3988400000000003';
