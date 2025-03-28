import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:rex_api/rex_api.dart';

class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService _instance = AnalyticsService._();
  static AnalyticsService get instance => _instance;

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> setUserID(String name) async {
    if (ApiConfig.shared.flavor == ApiFlavor.prod) {
      await analytics.setUserId(id: name);
    }
  }

  void logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (ApiConfig.shared.flavor == ApiFlavor.prod) {
      unawaited(analytics.logEvent(name: name, parameters: parameters));
    }
  }

  void logNavigation(String? routeName, String action) {
    if (ApiConfig.shared.flavor == ApiFlavor.prod) {
      if (routeName != null) {
        unawaited(analytics.logEvent(
          name: "screen_navigate",
          parameters: {"nav": "Screen $action: $routeName"},
        ));
      } else {
        unawaited(analytics.logEvent(
          name: "screen_navigate",
          parameters: {"nav": "missing route name"},
        ));
      }
    }
  }
}
