/// comment out the print function before creating a built for production
/// also comment out the dio.interceptors.add(PrettyDioLogger..)
/// in api_response.dart & dio_network_provider.dart
void debugPrintDev(String? message, {int? wrapWidth}) {
  print("DEBUG_PRINT: $message");
}
