import 'package:flutter/foundation.dart';
import 'app_config.dart';

/// Prints a debug message only when the app is running in dev flavor.
/// On production, this function does nothing.
void debugPrintDev(String? message, {int? wrapWidth}) {
  if (AppConfig.shared.flavor == Flavor.dev) {
    debugPrint(message, wrapWidth: wrapWidth);
  }
}
