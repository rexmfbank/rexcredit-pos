import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rex_app/src/utils/analytics/analytics_service.dart';

class AnalyticsNavigatorObserver extends NavigatorObserver {
  static const _name = "Navigation";

  AnalyticsService analyticsService;

  AnalyticsNavigatorObserver(this.analyticsService);

  @override
  void didPush(Route route, Route? previousRoute) {
    analyticsService.logNavigation(route.settings.name, 'push');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    analyticsService.logNavigation(route.settings.name, 'pop');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) {
      analyticsService.logNavigation(newRoute.settings.name, 'replace');
    }
  }

  void _logNavigation(String? routeName, String action) {
    if (routeName != null) {
      log("Screen $action: $routeName", name: _name);
    } else {
      log("Route name is missing", name: _name);
    }
  }
}
